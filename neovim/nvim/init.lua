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

local utils = require("utils")

-- -----------------------------------------------------------------------
--
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
vim.opt.copyindent = true
vim.opt.smartindent = true

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

-- Scout
if vim.fn.executable("scout") then
  if vim.fn.executable("rg") then
    require("scout").setup({
      files = {
        finder = [[rg --files --hidden --follow --glob "!.git/*" 2>/dev/null]],
      },
    })
  end

  utils.nmap("<leader>ff", [[:lua require('scout.files').run()<cr>]], { silent = true, hint = { "files", "open" } })
  utils.nmap(
    "<leader>fd",
    [[:lua require('scout.files').run({ search = '%:h' })<cr>]],
    { silent = true, hint = { "files", "current dir" } }
  )
  utils.nmap("<leader>bb", [[:lua require('scout.buffers').run()<cr>]], { silent = true, hint = { "buffers", "open" } })
  utils.nmap(
    "<leader>bd",
    [[:lua require('scout.buffers').run({ search = '%:h' })<cr>]],
    { silent = true, hint = { "buffers", "current dir" } }
  )

  utils.nmap(
    "<leader><space>",
    [[:lua require('scout.mappings').run({mode='n'})<cr>]],
    { silent = true, hint = { "keymaps", "show keymappings" } }
  )
  utils.map(
    "v",
    "<leader><space>",
    [[:lua require('scout.mappings').run({mode='v'})<cr>]],
    { silent = true, hint = { "maps", "show mappings" } }
  )
end

-- Colorscheme
vim.opt.background = "dark"
vim.cmd([[colorscheme rose-pine]])
