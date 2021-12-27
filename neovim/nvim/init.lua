local _ = require('utils')

-- -----------------------------------------------------------------------
--
-- Settings
-- -----------------------------------------------------------------------
vim.g.mapleader = ' '
vim.g.localeader = ','

_.mset {
  -- Backups
  {'nobackup'}, -- No backup
  {'noswapfile'}, -- No swap files

  -- Behaviors
  {'modeline'},
  {'hidden'}, -- don't remove buffers on close
  {'autoread'},
  {'nojoinspaces'}, -- put only one space after joining
  {'mouse', 'a'}, -- enable all mouse interactions

  -- Use the system clipboard as the default register
  {'clipboard', 'unnamed,unnamedplus'},

  -- Indentation
  {'tabstop', '2'}, -- number of visual spaces per TAB
  {'shiftwidth', '2'}, -- number of spaces to use for each step of (auto)indent
  {'softtabstop', '2'}, -- number of spaces in tab when editing
  {'shiftround'},
  {'expandtab'}, -- tabs are spaces
  {'copyindent'},
  {'smartindent'},

  -- Listchars
  {'listchars', [[trail:~,tab:▸\ ,eol:¬]]}, -- show special characters
  {'list'},

  -- Search
  {'ignorecase'},
  {'smartcase'}, -- override ignorecase if uppercase is used when searching
  {'hlsearch'},
  {'incsearch'}, -- search as you type

  -- Wildmenu
  {'wildmenu'},
  {'wildmode', 'list:longest,full'},

  -- Position
  {'number'},
  -- {'relativenumber'},
  {'visualbell'}, -- use visual bell, not sound
  {'shortmess', 'aI'}, -- modify the error and info messages
  {'scrolloff', '3'}, -- screen lines to keep above and below the cursor
  {'virtualedit', 'block'}, -- put the cursor anywhere in visual blocks
  {'cursorline'}, -- show where you are
  {'inccommand', 'split'},

  -- Prevent text jumping with linters/lsp integrations
  {'signcolumn', 'yes'},

  {'lazyredraw'},
}

-- Autosave
_.set {'updatetime', '750'}
vim.cmd [[au InsertLeave * ++nested silent! update]]
vim.cmd [[au CursorHold * ++nested silent! update]]


-- -----------------------------------------------------------------------
--
-- Packages
-- -----------------------------------------------------------------------
require('packer').startup(function(use)
  -- Packer can manage itself
  use {'wbthomason/packer.nvim'}

  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

  use {'tpope/vim-commentary'}
end)

-- -----------------------------------------------------------------------
--
-- Nvim Treesitter
--
-- NOTE: some parsers need node installed
-- TODO: Review configuration
-- -----------------------------------------------------------------------
require("nvim-treesitter.install").prefer_git = true
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
  -- TODO: look into textobjects config
}

-- use treesitter folding module
_.mset {
  {'foldlevel', 5},
  {'foldmethod', 'expr'},
  {'foldexpr', 'nvim_treesitter#foldexpr()'},
}
