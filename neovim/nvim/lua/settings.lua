----------------------------------------------------
-- Settings
----------------------------------------------------

-- Any setting set for (b)uffer or (w)indow has to be set
-- as global as well in order to make it work in all new buffers/windows
local function duplex(t, key, value)
  t.__target[key] = value
  vim.o[key] = value
end
local bo = setmetatable({ __target = vim.bo }, { __newindex = duplex })
local wo = setmetatable({ __target = vim.wo }, { __newindex = duplex })
local proxy = setmetatable({ bo = bo, wo = wo }, { __index = function(t, k) return vim[k] end })

proxy.g.mapleader = ' '
proxy.g.localeader = ','

-- Backups
proxy.o.backup = false -- No backup
proxy.bo.swapfile = false -- No swap files

-- Behaviors
proxy.bo.modeline = true
proxy.o.hidden = true -- don't remove buffers on close
proxy.o.autoread = true
proxy.o.joinspaces = false -- put only one space after joining
proxy.o.mouse = 'a' -- enable all mouse interactions

-- use the system clipboard as the default register
proxy.o.clipboard = 'unnamed,unnamedplus'

-- Indentation
proxy.bo.tabstop = 2 -- number of visual spaces per TAB
proxy.bo.shiftwidth = 2 -- number of spaces to use for each step of (auto)indent
proxy.bo.softtabstop = 2 -- number of spaces in tab when editing.
proxy.o.shiftround = true
proxy.bo.expandtab = true -- tabs are spaces
proxy.bo.copyindent = true
proxy.bo.smartindent = true

-- Listchars
proxy.o.listchars = [[trail:~,tab:▸\ ,eol:¬]] -- show special characters
proxy.wo.list = true

-- Search
proxy.o.ignorecase = true
proxy.o.smartcase = true -- override ignorecase if uppercase is used when searching
proxy.o.hlsearch = true
proxy.o.incsearch = true -- search as you type

-- Wildmenu
proxy.o.wildmenu = true
proxy.o.wildmode = 'list:longest,full'

-- Position
proxy.wo.number = true
proxy.wo.relativenumber = true
proxy.o.visualbell = true -- use visual bell, not sound
proxy.o.shortmess = 'aI' -- modify the error and info messages
proxy.o.scrolloff = 3 -- screen lines to keep above and below the cursor
proxy.o.virtualedit = 'block' -- put the cursor anywhere in visual blocks
proxy.wo.cursorline = true -- show where you are
proxy.o.inccommand = 'split'

-- Prevent text jumping with linters/lsp integrations
proxy.wo.signcolumn = 'yes'

proxy.o.lazyredraw = true

-- Autosave
proxy.o.updatetime = 750
proxy.cmd [[au InsertLeave * ++nested silent! update]]
proxy.cmd [[au CursorHold * ++nested silent! update]]
