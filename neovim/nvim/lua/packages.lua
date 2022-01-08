-- -----------------------------------------------------------------------
--
-- Packages
-- -----------------------------------------------------------------------
vim.cmd [[packadd packer.nvim]]

-- TODO: Install https://github.com/lewis6991/impatient.nvim
local function pkgs(use)
  -- Packer can manage itself
  use {'wbthomason/packer.nvim', opt = true}

  -- NOTE: some parsers need node installed
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = require('config.nvim-treesitter'),
  }

  use {'tpope/vim-commentary'}

  use { 'nacro90/numb.nvim', config = require('config.numb') }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
    config = require('config.nvim-tree')
  }
end

return require('packer').startup(pkgs, { disable_commands = true })
