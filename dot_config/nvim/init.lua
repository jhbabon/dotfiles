-- =======================================================================
--
--   NEOVIM configuration file
-- =======================================================================

-- Load impatient plugin before anything else to speed up lua loading
local ok, impatient = pcall(require, "impatient")
if not ok then
  -- This fails on fresh installs, so define the PackerSync command and exit early
  -- NOTE: This assumes that packer.nvim is installed in the pack path
  --
  -- To bootstrap nvim run this from the command line:
  --   nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
  vim.cmd([[command! PackerSync lua require('packages').sync()]])
  return
end

-- Enable profiling for module loading
-- impatient.enable_profile()

local keychain = require("keychain")

-- Settings
-- -----------------------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Backups
vim.opt.backup = false -- no backup
vim.opt.swapfile = false -- no swap files

-- Behaviors
vim.opt.modeline = true
vim.opt.hidden = true -- don't remove buffers on close
vim.opt.autoread = true
vim.opt.joinspaces = false -- put only one space after joining
vim.opt.mouse = "a" -- enable all mouse interactions

-- Use the system clipboard as the default register
vim.opt.clipboard = { "unnamed", "unnamedplus" }

-- Indentation
vim.opt.tabstop = 2 -- number of visual spaces per TAB
vim.opt.shiftwidth = 0 -- number of spaces to use for each step of (auto)indent. 0 uses tabstop
vim.opt.softtabstop = 2 -- number of spaces in tab when editing
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
vim.opt.hlsearch = true
vim.opt.incsearch = true -- search as you type

-- Wildmenu
vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest,full"

-- Position
vim.opt.number = true
vim.opt.visualbell = true -- use visual bell, not sound
vim.opt.shortmess = "aI" -- modify the error and info messages
vim.opt.scrolloff = 3 -- screen lines to keep above and below the cursor
vim.opt.virtualedit = "block" -- put the cursor anywhere in visual blocks
vim.opt.cursorline = true -- show where you are
vim.opt.inccommand = "split"

-- Prevent text jumping with linters/lsp integrations
vim.opt.signcolumn = "yes"

vim.opt.lazyredraw = true
vim.opt.termguicolors = true

-- Autosave
-- vim.opt.updatetime = 750
-- vim.cmd([[au InsertLeave * ++nested silent! update]])
-- vim.cmd([[au CursorHold * ++nested silent! update]])
keychain.set("n", "<leader>w", [[:w<cr>]], { hint = { "save", "save file" } })

-- Packages
require("packer_compiled")
-- redefine packer commands to lazy load it through the custom packages module
vim.cmd([[command! PackerInstall lua require('packages').install()]])
vim.cmd([[command! PackerUpdate lua require('packages').update()]])
vim.cmd([[command! PackerSync lua require('packages').sync()]])
vim.cmd([[command! PackerClean lua require('packages').clean()]])
vim.cmd([[command! PackerCompile lua require('packages').compile()]])

-- Scout: Fuzzy finder inside the editor
if vim.fn.executable("rg") then
  require("scout").setup({
    files = {
      finder = [[rg --files --hidden --follow --glob "!.git/*" 2>/dev/null]],
    },
  })
end

--- setup files fuzzy finder
keychain.set("n", "<leader>ff", function()
  return require("scout.files").run()
end, { hint = { "files", "open" } })
keychain.set("n", "<leader>fd", function()
  return require("scout.files").run({ search = "%:h" })
end, { hint = { "files", "current dir" } })

--- setup buffers fuzzy finder
keychain.set("n", "<leader>bb", function()
  return require("scout.buffers").run()
end, { hint = { "buffers", "open" } })
keychain.set("n", "<leader>bd", function()
  return require("scout.buffers").run({ search = "%:h" })
end, { hint = { "buffers", "current dir" } })

--- setup mappings fuzzy finder
keychain.set(
  "n",
  "<leader><space>",
  [[:lua require('scout.mappings').run({ mode='n', hints = require('keychain').hint })<cr>]],
  { hint = { "keymaps", "show keymappings" } }
)
keychain.vmap(
  "<leader><space>",
  [[:lua require('scout.mappings').run({ mode='v', hints = require('keychain').hint })<cr>]],
  { hint = { "maps", "show mappings" } }
)

-- General mappings
-- exit fast from insert mode
keychain.imap("jj", "<esc>")

local strip = table.concat({
  [[:let _s=winsaveview()]], -- save current cursor position
  [[:keeppatterns %s/\s\+$//e]], -- remove all trailing withespaces
  [[:call winrestview(_s)]], -- restore cursor position
  [[<cr>]], -- execute all of the above
}, "<Bar>") -- join all with '|' in one line
keychain.set("n", "<leader>u<space>", strip, { hint = { "misc", "remove trailing whitespace" } })
keychain.set("n", "<leader>u;", [[:s/\([^;]\)$/\1;/<cr>:noh<cr>]], { hint = { "misc", "add semicolon (;) at eol" } })
keychain.set("n", "<leader>u,", [[:s/\([^,]\)$/\1,/<cr>:noh<cr>]], { hint = { "misc", "add comma (,) at eol" } })
keychain.set("n", "<leader>fp", [[:let @+ = expand("%")<cr>]], { hint = { "files", "copy path" } })
keychain.set("n", "<leader>sc", [[:nohl<cr>]], { hint = { "search", "clear current highlight" } })

-- Explorer
-- Remove tons of stuff from netrw and set it a a tree to make it more comfortable to use
vim.g.netrw_liststyle = 3
keychain.set("n", "<leader>ft", [[:Explore<cr>]], { hint = { "files", "explorer" } })
