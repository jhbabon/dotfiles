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
vim.g.localeader = ","

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
vim.opt.shiftwidth = 2 -- number of spaces to use for each step of (auto)indent
vim.opt.softtabstop = 2 -- number of spaces in tab when editing
vim.opt.shiftround = true
vim.opt.expandtab = true -- tabs are spaces
vim.opt.copyindent = false
vim.opt.autoindent = false
vim.opt.smartindent = false

-- Listchars
vim.opt.list = true
vim.opt.listchars = { trail = [[~]], tab = [[▸\ ]], eol = [[¬]] } -- show special characters

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
vim.opt.updatetime = 750
vim.cmd([[au InsertLeave * ++nested silent! update]])
vim.cmd([[au CursorHold * ++nested silent! update]])

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
keychain.nmap("<leader>ff", [[:lua require('scout.files').run()<cr>]], { hint = { "files", "open" } })
keychain.nmap(
  "<leader>fd",
  [[:lua require('scout.files').run({ search = '%:h' })<cr>]],
  { hint = { "files", "current dir" } }
)

--- setup buffers fuzzy finder
keychain.nmap("<leader>bb", [[:lua require('scout.buffers').run()<cr>]], { hint = { "buffers", "open" } })
keychain.nmap(
  "<leader>bd",
  [[:lua require('scout.buffers').run({ search = '%:h' })<cr>]],
  { hint = { "buffers", "current dir" } }
)

--- setup mappings fuzzy finder
keychain.nmap(
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
keychain.nmap("<leader>u<space>", strip, { hint = { "misc", "remove trailing whitespace" } })
keychain.nmap("<leader>u;", [[:s/\([^;]\)$/\1;/<cr>:noh<cr>]], { hint = { "misc", "add semicolon (;) at eol" } })
keychain.nmap("<leader>u,", [[:s/\([^,]\)$/\1,/<cr>:noh<cr>]], { hint = { "misc", "add comma (,) at eol" } })
keychain.nmap("<leader>fp", [[:let @+ = expand("%")<cr>]], { hint = { "files", "copy path" } })
keychain.nmap("<leader>sc", [[:nohl<cr>]], { hint = { "search", "clear current highlight" } })

-- Explorer
-- Remove tons of stuff from netrw and set it a a tree to make it more comfortable to use
vim.g.netrw_liststyle = 3
keychain.nmap("<leader>ft", [[:Explore<cr>]], { hint = { "files", "explorer" } })