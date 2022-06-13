-- require("toggleterm").setup({
--     open_mapping = [[<C-k><C-t>]],
--     size = 40,
-- })
-- https://github.com/akinsho/toggleterm.nvim

local bmap = vim.api.nvim_buf_set_keymap
local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap

local Toggleterm = require("toggleterm")
Toggleterm.setup(
    {
        --  开启的终端默认进入插入模式
        start_in_insert = true,
        -- 设置终端打开的大小
        size = 6,
        -- 打开普通终端时，关闭拼写检查
        on_open = function()
            vim.cmd("setlocal nospell")
        end
    }
)
-- 新建终端
local Terminal = require("toggleterm.terminal").Terminal
local function inInsert()
    -- 删除 Esc 的映射
    vim.keybinds.dgmap("t", "<Esc>")
end
-- 新建浮动终端
local floatTerm =
    Terminal:new(
    {
        hidden = true,
        direction = "float",
        float_opts = {
            border = "double"
        },
        on_open = function(term)
            inInsert()
            -- 浮动终端中 Esc 是退出
            bmap(term.bufnr, "t", "<Esc>", "<C-\\><C-n>:close<CR>", opts)
        end,
        on_close = function()
            -- 重新映射 Esc
            map("t", "<Esc>", "<C-\\><C-n>", opts)
        end
    }
)
-- 新建 lazygit 终端
local lazyGit =
    Terminal:new(
    {
        cmd = "lazygit",
        hidden = true,
        direction = "float",
        float_opts = {
            border = "double"
        },
        on_open = function(term)
            inInsert()
            -- lazygit 中 q 是退出
            bmap(term.bufnr, "i", "q", "<cmd>close<CR>", opts)
        end,
        on_close = function()
            -- 重新映射 Esc
            map("t", "<Esc>", "<C-\\><C-n>", opts)
        end
    }
)
-- 定义新的方法
Toggleterm.float_toggle = function()
    floatTerm:toggle()
end
Toggleterm.lazygit_toggle = function()
    lazyGit:toggle()
end
-- 退出终端插入模式
map("t", "<Esc>", "<C-\\><C-n>", opts)
-- 打开普通终端
map("n", "<leader>tt", "<cmd>exe v:count.'ToggleTerm'<CR>", opts)
-- 打开浮动终端
map("n", "<leader>tf", "<cmd>lua require('toggleterm').float_toggle()<CR>", opts)
-- 打开lazy git 终端
map("n", "<leader>tg", "<cmd>lua require('toggleterm').lazygit_toggle()<CR>", opts)
-- 打开或关闭所有终端
map("n", "<leader>ta", "<cmd>ToggleTermToggleAll<CR>", opts)
-- 要需创建多个终端，可：
-- 1 <键位> leader tt
-- 2 <键位>
-- ... <键位>
-- 另外，上面我们新建了 2 个特殊终端，所以普通终端的顺序应该是从 3 开始
