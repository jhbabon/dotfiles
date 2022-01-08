-- -----------------------------------------------------------------------
--
-- Packages
-- -----------------------------------------------------------------------
vim.cmd [[packadd packer.nvim]]

local function config(name)
  return require('config.' .. name)
end

-- TODO: Install https://github.com/lewis6991/impatient.nvim
local function pkgs(use)
  -- Packer can manage itself
  use { 'wbthomason/packer.nvim', opt = true }

  -- Improve startup time for Neovim
  use { 'lewis6991/impatient.nvim' }

  -- NOTE: some parsers need node installed
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = config('nvim-treesitter'),
  }

  use { 'tpope/vim-commentary' }

  use { 'nacro90/numb.nvim', config = config('numb') }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
    config = config('nvim-tree'),
  }

  -- LSP
  use {
    'williamboman/nvim-lsp-installer',
    requires = {
      'neovim/nvim-lspconfig',
    },
    config = config('lsp'),
  }

  -- Lint and Formatting
  use({
    "jose-elias-alvarez/null-ls.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = config("null-ls"),
  })

  -- Git
  use { 'tpope/vim-fugitive' }
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = config('gitsigns'),
  }

  -- Colorschemes
  use { 'rose-pine/neovim', as = 'rose-pine', config = config('rose-pine') }
  use { 'marko-cerovac/material.nvim', config = config('material') }
  use { 'yonlu/omni.vim' }
end

return require('packer').startup({
  pkgs,
  config = {
    disable_commands = true,
    -- Move to lua dir so impatient.nvim can cache it
    compile_path = vim.fn.stdpath('config') .. '/lua/packer_compiled.lua',
  }
})
