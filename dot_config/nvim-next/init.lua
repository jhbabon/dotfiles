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
-- TODO: Check https://github.com/ojroques/nvim-osc52 for ssh copy&paste
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

-- Utils

-- Build a description for a keymap.
-- A description has the form: { "label", "explanation" }
-- Example:
--   _G.desc({ "files", "explore files" }) -- files -> explore files
function _G.desc(description)
	return string.format("%s -> %s", unpack(description))
end

-- Mappings
vim.keymap.set("i", "jj", "<esc>")

vim.keymap.set("n", "<leader>u<space>", function()
	-- save current cursor positionn
	local s = vim.fn.winsaveview()
	-- remove all trailing white spaces
	vim.cmd([[:keeppatterns %s/\s\+$//e]])
	-- restore cursor positionn
	vim.fn.winrestview(s)
end, { desc = _G.desc({ "misc", "remove trailing whitespace" }) })
vim.keymap.set(
	"n",
	"<leader>u;",
	[[:s/\([^;]\)$/\1;/<cr>:noh<cr>]],
	{ desc = _G.desc({ "misc", "add semicolon (;) at eol" }) }
)
vim.keymap.set(
	"n",
	"<leader>u,",
	[[:s/\([^,]\)$/\1,/<cr>:noh<cr>]],
	{ desc = _G.desc({ "misc", "add comma (,) at eol" }) }
)
vim.keymap.set("n", "<leader>fp", function()
	vim.fn.setreg("+", vim.fn.expand("%"))
end, { desc = _G.desc({ "files", "copy path" }) })
vim.keymap.set("n", "<leader>sc", [[:nohl<cr>]], { desc = _G.desc({ "search", "clear current highlight" }) })

vim.api.nvim_create_autocmd("User", {
	pattern = "Bootstrap",
	callback = function()
		local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
		ts_update()
	end,
})
