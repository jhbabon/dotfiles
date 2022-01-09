-- -----------------------------------------------------------------------
--
-- Packages
-- -----------------------------------------------------------------------
vim.cmd([[packadd packer.nvim]])

local function config(name)
  return require("config." .. name)
end

local function pkgs(use)
  -- Packer can manage itself
  use({ "wbthomason/packer.nvim", opt = true })

  -- Improve startup time for Neovim
  use({ "lewis6991/impatient.nvim" })

  use({ "kyazdani42/nvim-web-devicons" })

  -- NOTE: some parsers need node installed
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = config("nvim-treesitter"),
  })

  -- Projects
  use({ "klen/nvim-config-local", config = config("config-local") })
  use({ "tpope/vim-projectionist", setup = config("pre.projectionist") })
  use({ "wfxr/minimap.vim", run = "cargo install --locked code-minimap", setup = config("minimap") })

  -- Editing
  use({ "windwp/nvim-autopairs", config = config("nvim-autopairs") })
  use({ "nacro90/numb.nvim", config = config("numb") })
  use({ "tpope/vim-commentary" })
  use({ "tpope/vim-surround", requires = { "tpope/vim-repeat" } })
  use({ "tpope/vim-eunuch" })

  -- Autocomplete + snippets
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
    config = config("cmp"),
  })

  -- LSP
  use({
    "williamboman/nvim-lsp-installer",
    requires = {
      "folke/trouble.nvim", -- mappings
      "neovim/nvim-lspconfig",
    },
    config = config("lsp"),
  })

  -- Diagnostics
  use({
    "folke/trouble.nvim",
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
    config = config("trouble"),
  })

  -- Lint and Formatting
  use({
    "jose-elias-alvarez/null-ls.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = config("null-ls"),
  })

  -- Git
  use({ "tpope/vim-fugitive", config = config("fugitive") })
  use({
    "lewis6991/gitsigns.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = config("gitsigns"),
  })

  -- Search
  use({
    "mhinz/vim-grepper",
    requires = {
      "folke/trouble.nvim",
    },
    setup = config("pre.grepper"),
  })
  use({ "pechorin/any-jump.vim", setup = config("pre.any-jump") })

  -- Colorschemes
  use({ "rose-pine/neovim", as = "rose-pine", config = config("rose-pine") })
  use({ "marko-cerovac/material.nvim", config = config("material") })
  use({ "yonlu/omni.vim" })

  -- Statusline
  use({ "nvim-lualine/lualine.nvim", config = config("lualine") })

  -- Show indent lines
  use({ "lukas-reineke/indent-blankline.nvim", config = config("indent-blankline") })
end

return require("packer").startup({
  pkgs,
  config = {
    disable_commands = true,
    -- Move to lua dir so impatient.nvim can cache it
    compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
  },
})
