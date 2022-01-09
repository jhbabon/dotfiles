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

  -- NOTE: some parsers need node installed
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = config("nvim-treesitter"),
  })

  -- Editing
  use({
    "windwp/nvim-autopairs",
    config = config("nvim-autopairs"),
  })
  use({ "nacro90/numb.nvim", config = config("numb") })
  use({ "tpope/vim-commentary" })
  use({ "tpope/vim-surround", requires = { "tpope/vim-repeat" } })
  use({ "tpope/vim-eunuch" })

  -- File Explorer
  -- TODO: Do I need this?
  use({
    "kyazdani42/nvim-tree.lua",
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
    config = config("nvim-tree"),
  })

  -- LSP
  use({
    "williamboman/nvim-lsp-installer",
    requires = {
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

  -- Colorschemes
  use({ "rose-pine/neovim", as = "rose-pine", config = config("rose-pine") })
  use({ "marko-cerovac/material.nvim", config = config("material") })
  use({ "yonlu/omni.vim" })

  -- Statusline
  use({ "nvim-lualine/lualine.nvim", config = config("lualine") })

  -- Show indent lines
  use({
    "lukas-reineke/indent-blankline.nvim",
    config = config("indent-blankline"),
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
