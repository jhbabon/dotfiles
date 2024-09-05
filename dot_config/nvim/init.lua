if vim.fn.has("nvim-0.9") == 1 then
	-- enable new experimental loader
	vim.loader.enable()
end

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Backups
vim.opt.backup = false   -- no backup
vim.opt.swapfile = false -- no swap files

-- Plugins
vim.g.loaded_matchit = 1 -- do not load built in matchit

-- Behaviors
vim.opt.modeline = true    -- allow modelines in files
vim.opt.hidden = true      -- keep a buffer even if it's closed
vim.opt.autoread = true    -- automatically read changes done outside vim
vim.opt.joinspaces = false -- put only one space after joining
vim.opt.mouse = "a"        -- enable all mouse interactions

-- Use the system clipboard as the default register
vim.opt.clipboard = { "unnamed", "unnamedplus" }

-- Indentation
vim.opt.tabstop = 2      -- number of visual spaces per TAB
vim.opt.shiftwidth = 0   -- number of spaces to use for each step of (auto)indent. 0 uses tabstop
vim.opt.softtabstop = 2  -- number of spaces in tab when editing
vim.opt.shiftround = true
vim.opt.expandtab = true -- tabs are spaces
vim.opt.copyindent = false
vim.opt.autoindent = false
vim.opt.smartindent = false

-- Listchars
vim.opt.list = true
-- show special characters
vim.opt.listchars = {
	trail = [[~]],
	tab = [[▸ ]],
	eol = [[¬]],
}

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true -- override ignorecase if uppercase is used when searching
vim.opt.hlsearch = true  -- highlight the search
vim.opt.incsearch = true -- search as you type

-- Wildmenu
vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest,full"

-- Position
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.visualbell = true     -- use visual bell, not sound
vim.opt.shortmess = "aI"      -- modify the error and info messages
vim.opt.scrolloff = 3         -- screen lines to keep above and below the cursor
vim.opt.virtualedit = "block" -- put the cursor anywhere in visual blocks
vim.opt.cursorline = true     -- show where you are
vim.opt.inccommand = "split"

-- Prevent text jumping with linters/lsp integrations
vim.opt.signcolumn = "yes"

-- Full colors
vim.opt.termguicolors = true

-- Load local config files
vim.opt.exrc = true

-- Mappings
local clue = require("clue")

vim.keymap.set("i", "jj", "<esc>")

local _u = clue("n", "<leader>u", "misc")
vim.keymap.set("n", _u("<space>"), function()
	-- save current cursor positionn
	local s = vim.fn.winsaveview()
	-- remove all trailing white spaces
	vim.cmd([[:keeppatterns %s/\s\+$//e]])
	-- restore cursor positionn
	vim.fn.winrestview(s)
end, { desc = "remove trailing whitespace" })

vim.keymap.set("n", _u(";"), [[:s/\([^;]\)$/\1;/<cr>:noh<cr>]], { desc = "add semicolon (;) at eol" })

vim.keymap.set("n", _u(","), [[:s/\([^,]\)$/\1,/<cr>:noh<cr>]], { desc = "add comma (,) at eol" })

local _f = clue("n", "<leader>f", "files")
vim.keymap.set("n", _f.p, function()
	vim.fn.setreg("+", vim.fn.expand("%"))
end, { desc = "copy file path" })

local _s = clue("n", "<leader>s", "search")
vim.keymap.set("n", _s.c, [[:nohl<cr>]], { desc = "clear current search highlight" })
