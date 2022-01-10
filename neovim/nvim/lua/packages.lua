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
  use({
    "wfxr/minimap.vim",
    run = "cargo install --locked code-minimap",
    setup = require("conf-minimap"),
  })

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

  -- Autocomplete + snippets
  -- use({
  --   "hrsh7th/nvim-cmp",
  --   requires = {
  --     "hrsh7th/cmp-nvim-lsp",
  --     "hrsh7th/cmp-buffer",
  --     "onsails/lspkind-nvim",
  --     "L3MON4D3/LuaSnip",
  --     "saadparwaiz1/cmp_luasnip",
  --     "rafamadriz/friendly-snippets",
  --   },
  --   config = require("conf-cmp"),
  -- })

  -- LSP
  use({
    "neovim/nvim-lspconfig",
    requires = {
      "folke/trouble.nvim", -- for mappings
      "williamboman/nvim-lsp-installer",
      "nvim-lua/plenary.nvim",
      "jose-elias-alvarez/null-ls.nvim",
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

  -- Colorschemes
  use({
    "rose-pine/neovim",
    requires = {
      -- these are not required, but this way they are grouped
      "marko-cerovac/material.nvim",
      "yonlu/omni.vim",
    },
    as = "rose-pine",
    config = require("conf-colors"),
  })

  -- Statusline
  use({ "nvim-lualine/lualine.nvim", config = require("conf-lualine") })

  -- Show indent lines
  use({
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup({
        char = "‧",
        show_current_context = true,
      })
    end,
  })
end

return require("packer").startup({
  pkgs,
  config = {
    disable_commands = true,
    -- Move to lua dir so impatient.nvim can cache it
    compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
  },
})
