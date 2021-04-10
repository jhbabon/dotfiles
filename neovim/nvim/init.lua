----------------------------------------------------
-- Helpers
----------------------------------------------------
function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end

  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function imap(...)
  map('i', ...)
end

function nmap(...)
  map('n', ...)
end

----------------------------------------------------
-- Settings
----------------------------------------------------

vim.g.mapleader = ' '
vim.g.localeader = ','

-- Backups
vim.o.backup = false -- No backup
vim.bo.swapfile = false -- No swap files

-- Behaviors
vim.bo.modeline = true
vim.o.hidden = true -- don't remove buffers on close
vim.o.autoread = true
vim.o.joinspaces = false -- put only one space after joining
vim.o.mouse = 'a' -- enable all mouse interactions

-- use the system clipboard as the default register
vim.o.clipboard = 'unnamed,unnamedplus'

-- Indentation
vim.bo.tabstop = 2 -- number of visual spaces per TAB
vim.bo.shiftwidth = 2 -- number of spaces to use for each step of (auto)indent
vim.bo.softtabstop = 2 -- number of spaces in tab when editing.
vim.o.shiftround = true
vim.bo.expandtab = true -- tabs are spaces
vim.bo.copyindent = true
vim.bo.smartindent = true

-- Listchars
vim.o.listchars = [[trail:~,tab:▸\ ,eol:¬]] -- show special characters
vim.wo.list = true

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true -- override ignorecase if uppercase is used when searching
vim.o.hlsearch = true
vim.o.incsearch = true -- search as you type

-- Wildmenu
vim.o.wildmenu = true
vim.o.wildmode = 'list:longest,full'

-- Position
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.visualbell = true -- use visual bell, not sound
vim.o.shortmess = 'aI' -- modify the error and info messages
vim.o.scrolloff = 3 -- screen lines to keep above and below the cursor
vim.o.virtualedit = 'block' -- put the cursor anywhere in visual blocks
vim.wo.cursorline = true -- show where you are
vim.o.inccommand = 'split'

-- Prevent text jumping with linters/lsp integrations
vim.wo.signcolumn = 'yes'

vim.o.lazyredraw = true

-- Autosave
vim.o.updatetime = 750
vim.cmd [[au InsertLeave * ++nested silent! update]]
vim.cmd [[au CursorHold * ++nested silent! update]]

----------------------------------------------------
-- Packages
----------------------------------------------------
-- TODO: Load only on demand
vim.cmd [[packadd paq-nvim]]
local paq = require('paq-nvim').paq

-- Let paq-nvim manage itself
paq {'savq/paq-nvim', opt = true}

-- TODO: Find/reuse packages for
-- git: signs (?), commits, etc
-- comments: add, remove, etc

paq {'nvim-treesitter/nvim-treesitter', run = function() vim.cmd('TSUpdate') end}
paq {'RRethy/nvim-base16'}

paq {'wfxr/minimap.vim', opt = true}

-- TODO: Review if it needs to be optional
paq {'liuchengxu/vim-which-key', opt = true}
paq {'AckslD/nvim-whichkey-setup.lua'}


-- paq{'nvim-lua/plenary.nvim'}
-- paq{'lewis6991/gitsigns.nvim'}

-- nvim-treesitter
-- NOTE: some parsers need node installed
require('nvim-treesitter.configs').setup {
  ensure_installed = 'maintained',
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
  },
  indent = {
    enable = true,
  },
}
vim.wo.foldlevel = 5
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'

-- minimap.vim
vim.g.minimap_close_filetypes = {'startify', 'netrw', 'vim-plug', 'which_key'}
vim.g.minimap_auto_start = true
vim.g.minimap_auto_start_win_enter = true
vim.cmd [[packadd! minimap.vim]]

-- vim-which-key
function which_key_format(label)
  local name, _ = string.gsub(label, [[<cr>$]], '')
  name, _ = string.gsub(name, [[^:]], '')
  name, _ = string.gsub(name, [[^<[Pp]lug>]], '')

  return name
end
-- So the WhichKeyFormatFunc is a lua function, but vim-which-key expects a Funcref in vim
-- world. Let's use a lambda to call internally the lua function
vim.cmd([[let g:WhichKeyFormatFunc = {s -> v:lua.which_key_format(s)}]])
vim.cmd [[packadd! vim-which-key]]

-- Colorscheme
vim.cmd('syntax on')
vim.cmd('syntax reset')
vim.o.termguicolors = true
require('base16-colorscheme').setup('onedark')
vim.cmd('filetype plugin indent on')

-- Utils
local strip_trailing_whitespace = [[:let _s=winsaveview()<Bar>:keeppatterns %s/\s\+$//e<Bar>:call winrestview(_s)<Bar><cr>]]
nmap('<plug>(misc-strip-trailing-whitespace)', strip_trailing_whitespace)
nmap('<plug>(misc-semicolon-eol)', [[:s/\([^;]\)$/\1;/<cr>:noh<cr>]])
nmap('<plug>(misc-comma-eol)', [[:s/\([^,]\)$/\1,/<cr>:noh<cr>]])

-- Mappings
local wk = require('whichkey_setup')
wk.config()
local keymap = {}

-- exit fast from insert mode
imap('jj', '<esc>')

keymap.m = { name = '(misc)' }
nmap('<leader>m<space>', '<plug>(misc-strip-trailing-whitespace)', {silent=true, noremap=false})
nmap('<leader>m,', '<plug>(misc-comma-eol)', {silent=true, noremap=false})
nmap('<leader>m;', '<plug>(misc-semicolon-eol)', {silent=true, noremap=false})

wk.register_keymap('leader', keymap)
