----------------------------------------------------
-- Settings
----------------------------------------------------
local set = require('helpers').set

vim.g.mapleader = ' '
vim.g.localeader = ','

-- Backups
set {'nobackup'} -- No backup
set {'noswapfile'} -- No swap files

-- Behaviors
set {'modeline'}
set {'hidden'} -- don't remove buffers on close
set {'autoread'}
set {'nojoinspaces'} -- put only one space after joining
set {'mouse', 'a'} -- enable all mouse interactions

-- use the system clipboard as the default register
set {'clipboard', 'unnamed,unnamedplus'}

-- Indentation
set {'tabstop', '2'} -- number of visual spaces per TAB
set {'shiftwidth', '2'} -- number of spaces to use for each step of (auto)indent
set {'softtabstop', '2'} -- number of spaces in tab when editing.
set {'shiftround'}
set {'expandtab'} -- tabs are spaces
set {'copyindent'}
set {'smartindent'}

-- Listchars
set {'listchars', [[trail:~,tab:▸\ ,eol:¬]]} -- show special characters
set {'list'}

-- Search
set {'ignorecase'}
set {'smartcase'} -- override ignorecase if uppercase is used when searching
set {'hlsearch'}
set {'incsearch'} -- search as you type

-- Wildmenu
set {'wildmenu'}
set {'wildmode', 'list:longest,full'}

-- Position
set {'number'}
set {'relativenumber'}
set {'visualbell'} -- use visual bell, not sound
set {'shortmess', 'aI'} -- modify the error and info messages
set {'scrolloff', '3'} -- screen lines to keep above and below the cursor
set {'virtualedit', 'block'} -- put the cursor anywhere in visual blocks
set {'cursorline'} -- show where you are
set {'inccommand', 'split'}

-- Prevent text jumping with linters/lsp integrations
set {'signcolumn', 'yes'}

set {'lazyredraw'}

-- Autosave
set {'updatetime', '750'}
vim.cmd [[au InsertLeave * ++nested silent! update]]
vim.cmd [[au CursorHold * ++nested silent! update]]
