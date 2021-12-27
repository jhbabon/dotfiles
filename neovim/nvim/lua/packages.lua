-- -----------------------------------------------------------------------
--
-- Packages
-- -----------------------------------------------------------------------
vim.cmd [[packadd packer.nvim]]

-- autocompile packer on file changes
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packages.lua source <afile> | PackerCompile
  augroup end
]])

-- TODO: Install https://github.com/lewis6991/impatient.nvim
return require('packer').startup(function(use)
  -- Packer can manage itself
  use {'wbthomason/packer.nvim', opt = true}

  -- NOTE: some parsers need node installed
  -- TODO: Review configuration
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      -- require("nvim-treesitter.install").prefer_git = true
      require('nvim-treesitter.configs').setup {
        ensure_installed = 'maintained',
        sync_install = false,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false, -- TODO: Review
        },
        incremental_selection = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      }
    end,
  }

  use {'tpope/vim-commentary'}

  use {
    'nacro90/numb.nvim',
    config = function()
      require('numb').setup()
    end
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup {
        disable_netrw = false,
        hijack_netrw = false,
      }
    end
  }
end, { disable_commands = true })
