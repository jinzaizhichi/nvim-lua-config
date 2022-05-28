-- lua/config/nvim-tree.lua
--vim.g.render.indent_markers = 1
 --vim.g.nvim_tree_indent_markers = 1
--vim.g.nvim_tree_add_trailing = 1
-- vim.g.nvim_tree_add_trailing = 1
-- vim.g.nvim_tree_special_files = { "README.md", "Makefile", "MAKEFILE", "package.json", "composer.json" }
-- vim.g.nvim_tree_show_icons = {
--     git = 1,
--     folders = 1,
--     files = 1,
--     folder_arrows = 1
-- }

require("nvim-tree").setup({
    diagnostics = {
        enable = true,
    },
    git = {
        ignore = false,
    },
    view = {
        width = 40,
        side = "right",
        mappings = {
            list = {
                { key = "<C-k>", action = "" },
                { key = "i", action = "toggle_file_info" },
            },
        },
   },
    renderer = {
        add_trailing = false,
        group_empty = false,
        highlight_git = false,
        highlight_opened_files = "none",
        root_folder_modifier = ":~",
        indent_markers = {
            enable = false,
            icons = {
            corner = "└ ",
            edge = "│ ",
            none = "  ",
          },
        },
    },
})
