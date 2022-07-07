-- lua/plugins.lua

-- Place where packer is goint to be saved
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- Install packer from github if is not in our system
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected require call (pcall) so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Show packer messages in a popup. Looks cooler
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

-- Alt installation of packer without a function
packer.reset()
local use = packer.use

--[[
  Start adding plugins here
--]]
use({ -- Have packer manage itself
    "wbthomason/packer.nvim",
})
use({ -- A collection of material based themes.
    "marko-cerovac/material.nvim",
})
use({ -- Monokay, Monokay-pro, Monokay-Soda  and Monokay-Ristretto themes
    "tanvirtin/monokai.nvim",
})
use({ -- Port of VSCode's Tokio Night theme
    "folke/tokyonight.nvim",
})
use({ -- Adaptation of the Sublime Text theme of the same name.
    "adrian5/oceanic-next-vim",
})
use({ -- Another cool dark theme
    "EdenEast/nightfox.nvim",
    config = function()
        require("config.nightfox")
    end,
})
use({ -- GitHub inspired theme. Supports light and dark
    "projekt0n/github-nvim-theme",
})
use({ -- Install and configure treesitter languages
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
        require("config.treesitter")
    end,
})
use({ -- Configure LSP client and Use an LSP server installer.
    "neovim/nvim-lspconfig",
    requires = {
        "williamboman/nvim-lsp-installer", -- Installs servers within neovim
        "onsails/lspkind-nvim", -- adds vscode-like pictograms to neovim built-in lsp
        "b0o/schemastore.nvim", -- Auto validation some json files like package.json or .esltitrc.json
    },
    config = function()
        require("config.lsp")
    end,
})
use({ -- CMP completion engine
    "hrsh7th/nvim-cmp",
    requires = {
        "onsails/lspkind-nvim", -- Icons on the popups
        "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
        "hrsh7th/cmp-buffer", -- Buffer source for nvim-cmp
        "saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-mcp
        "L3MON4D3/LuaSnip", -- Snippet engine
    },
    config = function()
        require("config.cmp")
    end,
})
use({ -- Null-LS Use external formatters and linters
    "jose-elias-alvarez/null-ls.nvim",
    requires = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("config.null-ls")
    end,
})
use({ -- Trouble: pretty diagnostics
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
        require("trouble").setup({})
    end,
})
use({ -- Telescope: The swiws army knife of searching
    "nvim-telescope/telescope.nvim",
    requires = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-frecency.nvim", -- Better sorting algorithm
            "tami5/sqlite.lua",
        },
        "nvim-telescope/telescope-ui-select.nvim",
        "nvim-telescope/telescope-node-modules.nvim",
        "nvim-telescope/telescope-live-grep-args.nvim",
        "nvim-telescope/telescope-symbols.nvim",
    },
    config = function()
        require("config.telescope")
    end,
})
use({ -- Allows you to use `:Rg <search_string>` for fast project search
    "rinx/nvim-ripgrep",
    config = function()
        require("nvim-ripgrep").setup({
            open_qf_fn = require("nvim-ripgrep.extensions").trouble_open_qf,
        })
    end,
})
use({ -- GitSigns: how signs(+, -, ~ ) on the gutter for changed lines on gir tracked files
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
        require("config.gitsigns")
    end,
})
use({ -- Interact with github directly in NeoVim. `:Octo <tab>` for options
    "pwntester/octo.nvim",
    requires = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "kyazdani42/nvim-web-devicons",
    },
    config = function()
        require("octo").setup()
    end,
})
use({ -- Support for .editorconfig files
    "gpanders/editorconfig.nvim",
})
use({ -- Nvim-tree: Sidebar explorer and NetRW replacement
    "kyazdani42/nvim-tree.lua",
    requires = {
        "kyazdani42/nvim-web-devicons", -- optional, for file icon
    },
    config = function()
        require("config.nvim-tree")
    end,
})
use({ -- Floating terminal with C-k C-t
    "akinsho/toggleterm.nvim",
    config = function()
        require("config.toggleterm")
    end,
})
use({ -- Add indentation guides even on blank lines
    "lukas-reineke/indent-blankline.nvim",
    config = function()
        require("config.indent-blankline")
    end,
})
use({ -- Make the status line beautiful and more useful
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = function()
        require("config.lualine")
    end,
})
use({ -- Whichkey: popup help for keymaps
    "folke/which-key.nvim",
    config = function()
        require("config.which-key")
    end,
})
use({ -- Fast commenting! Enable gcc and gcb for comments
    "numToStr/Comment.nvim",
    config = function()
        require("Comment").setup()
    end,
})
use({ -- Align items with `:SimpleAlign --` for instance
    "kg8m/vim-simple-align",
})
use({ -- Preview current markdown file with :MarkdownPreview
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = { "markdown" },
    cmd = { "MarkdownPreview", "MarkdownPreviewToggle" }, -- Load on this commands
})
use({ -- Shows you inside your `packaje.json` which packages can be upgraded
    "vuki656/package-info.nvim",
    requires = "MunifTanjim/nui.nvim",
    config = function()
        require("package-info").setup()
    end,
})
use({ -- Show the actual color or RGB or CMYK values in your code
    "norcalli/nvim-colorizer.lua",
    config = function()
        require("colorizer").setup()
    end,
})
--[[
  Finish plugin configuration
--]]

-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
if PACKER_BOOTSTRAP then
    require("packer").sync()
end
