-- lua/keymaps.lua

-- Modes
--   normal_mode       = "n",
--   insert_mode       = "i",
--   visual_mode       = "v",
--   visual_block_mode = "x",
--   term_mode         = "t",
--   command_mode      = "c",

-- Some shortcuts to make the conf file more clean
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local expr = { noremap = true, silent = true, expr = true }

-- Map leader key to space
map("n", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Don't jump when using *
map("n", "*", "*<C-o>", opts)

-- Keep search matches in the middle of the window
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

-- Toggle NetRW (Lexplore)
map("n", "<Leader>le", ":Lexplore<Cr>", opts)

-- Clear matches with Ctrl+l
map("n", "<C-l>", ":noh<Cr>", opts)

-- Reselect visual block after indent/outdent
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- YY/XX Copy/Cut into the system clipboard
vim.cmd([[
noremap YY "+y<CR>
noremap XX "+x<CR>
]])

-- Doble ESC or <C-s> to go to normal mode in terminal
map("t", "<C-s>", "<C-\\><C-n>", opts)
map("t", "<Esc><Esc>", "<C-\\><C-n>", opts)

-- Resize windows with Shift+<arrow>
map("n", "<S-Up>", ":resize +2<CR>", opts)
map("n", "<S-Down>", ":resize -2<CR>", opts)
map("n", "<S-Left>", ":vertical resize -2<CR>", opts)
map("n", "<S-Right>", ":vertical resize +2<CR>", opts)

-- Move line up and down with J/K
map("x", "J", ":move '>+1<CR>gv-gv", opts)
map("x", "K", ":move '<-2<CR>gv-gv", opts)

-- Modify j and k when a line is wrapped. Jump to next VISUAL line
map("n", "k", "v:count == 0 ? 'gk' : 'k'", expr)
map("n", "j", "v:count == 0 ? 'gj' : 'j'", expr)

-- Only works on  Material Theme: Toggle themes with <leader+mm>, Change style with <Leader+me>
map("n", "<leader>mm", [[<Cmd>lua require('material.functions').toggle_style()<CR>]], opts)
map("n", "<leader>me", [[<Cmd>lua require('material.functions').toggle_eob()<CR>]], opts)

-- LSP Additional
vim.api.nvim_buf_set_keymap(0, 'n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

-- Telescope
map("n", "<leader>ff", "<cmd>lua require(\"telescope.builtin\").find_files()<cr>", opts)
map("n", "<leader>fg", "<cmd>lua require(\"telescope.builtin\").live_grep()<cr>", opts)
map("n", "<leader>fu", "<cmd>lua require(\"telescope.builtin\").buffers()<cr>", opts)
map("n", "<C-k><C-l>", "<cmd>lua require(\"telescope.builtin\").buffers()<cr>", opts)
map("n", "<leader>fh", "<cmd>lua require(\"telescope.builtin\").help_tags()<cr>", opts)
map("n", "<leader>fs", "<cmd>lua require(\"telescope.builtin\").git_status()<cr>", opts)
map("n", "<leader>fd", "<cmd>lua require(\"telescope.builtin\").diagnostics()<cr>", opts)

-- Nvim-Tree
map("n", "<C-k><C-k>", "<cmd>NvimTreeToggle<cr>", opts)
map("n", "<C-k><C-f>", "<cmd>NvimTreeFindFile<cr>", opts)

-- vim: ts=2 sw=2 et
