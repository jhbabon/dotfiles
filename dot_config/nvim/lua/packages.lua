-- Packages
-- -----------------------------------------------------------------------
vim.cmd([[packadd packer.nvim]])

local function pkgs(use)
  -- Packer can manage itself
  use({ "wbthomason/packer.nvim", opt = true })

  -- Improve startup time for Neovim
  use({ "lewis6991/impatient.nvim" })

  use({ "kyazdani42/nvim-web-devicons" })

  -- NOTE: some parsers need node installed
  use({
    "nvim-treesitter/nvim-treesitter",
    requires = {
      "andymass/vim-matchup",
      "romgrk/nvim-treesitter-context",
    },
    run = ":TSUpdate",
    setup = function()
      vim.g.loaded_matchit = 1
    end,
    config = require("conf-treesitter"),
  })

  -- Projects
  use({
    "klen/nvim-config-local",
    config = function()
      require("config-local").setup({ commands_create = false })
    end,
  })
  use({ "tpope/vim-projectionist", setup = require("setup-projectionist") })
  use({ "wfxr/minimap.vim", setup = require("conf-minimap") })
  use({ "sidebar-nvim/sidebar.nvim", config = require("conf-sidebar") })

  -- Editing
  use({
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({ enable_check_bracket_line = false })
    end,
  })
  use({ "tpope/vim-commentary" })
  use({ "tpope/vim-surround", requires = { "tpope/vim-repeat" } })
  use({ "tpope/vim-eunuch" })
  use({ "tpope/vim-vinegar" })
  use({ "tpope/vim-characterize" })

  -- Autocomplete
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "onsails/lspkind-nvim",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = require("conf-cmp"),
  })

  -- LSP
  use({
    "neovim/nvim-lspconfig",
    requires = {
      "folke/trouble.nvim", -- for mappings
      "williamboman/nvim-lsp-installer",
      "nvim-lua/plenary.nvim",
      "jose-elias-alvarez/null-ls.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = require("conf-lsp"),
  })

  -- Diagnostics
  use({
    "folke/trouble.nvim",
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
    config = require("conf-trouble"),
  })

  -- Git
  use({
    "lewis6991/gitsigns.nvim",
    requires = {
      "tpope/vim-fugitive",
      "nvim-lua/plenary.nvim",
    },
    config = require("conf-git"),
  })

  -- Search
  use({
    "mhinz/vim-grepper",
    requires = {
      "folke/trouble.nvim",
    },
    setup = require("setup-grepper"),
  })
  use({ "pechorin/any-jump.vim", setup = require("setup-any-jump") })

  -- Colorschemes & statusline
  use({
    "nvim-lualine/lualine.nvim",
    requires = {
      "marko-cerovac/material.nvim",
      "EdenEast/nightfox.nvim",
      "sainnhe/everforest",
      "rebelot/kanagawa.nvim",
      { "rose-pine/neovim", as = "rose-pine" },
    },
    config = require("conf-colors"),
  })

  -- Show indent lines
  use({
    "echasnovski/mini.nvim",
    config = function()
      require("mini.indentscope").setup({
        symbol = "‧",
      })
    end,
  })

  -- Dim inactive portions of the code you're editing
  use({
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup({
        context = 15,
      })

      local keychain = require("keychain")
      keychain.nmap("<leader>uf", [[:Twilight<cr>]], { hint = { "misc", "focus with Twilight" } })
    end,
  })

  -- Terminal manipulation
  use({
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({})

      local keychain = require("keychain")
      keychain.nmap(
        "<leader>tt",
        [[<Cmd>exe v:count1 . "ToggleTerm"<CR>]],
        { hint = { "terminal", "toggle terminal" } }
      )
    end,
  })
end

return require("packer").startup({
  pkgs,
  config = {
    disable_commands = true,
    -- Move to lua dir so impatient.nvim can cache it
    compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
    -- Remove comments to enable profiling
    -- profile = {
    --   enable = true,
    --   threshold = 1, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    -- },
  },
})
