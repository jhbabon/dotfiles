---Configure several mini plugins: https://github.com/echasnovski/mini.nvim
-- Library of 30+ independent Lua modules improving overall
-- Neovim experience with minimal effort
-----------------------------------------------------------------------
if vim.g.__mini_plugin__ then
	return true
end
vim.g.__mini_plugin__ = true

-- Session management
require("mini.sessions").setup({
	-- local session file
	file = "Session.vim",
})

local function save()
	-- Save current session in local session file
	require("mini.sessions").write("Session.vim", {})
end

local function load()
	-- Load current session from local session file
	require("mini.sessions").read("Session.vim", {})
end

vim.keymap.set("n", "<leader>cs", save, { desc = _G.desc({ "checkpoint", "save current session" }) })
vim.keymap.set("n", "<leader>cl", load, { desc = _G.desc({ "checkpoint", "load last session" }) })

-- Start screen
local starter = require("mini.starter")
starter.setup({
	items = {
		starter.sections.sessions(5, true),
		{
			{
				name = "Open file",
				action = [[Telescope find_files theme=dropdown]],
				section = "Navigate",
			},
			{
				name = "Search word",
				action = [[lua vim.api.nvim_feedkeys(":GrepperRg ", "n", false)]],
				section = "Navigate",
			},
		},
		starter.sections.recent_files(5, false, false),
		starter.sections.builtin_actions(),
	},
})

-- Clue
local miniclue = require('mini.clue')
miniclue.setup({
  triggers = {
    -- Leader triggers
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },

    -- Built-in completion
    { mode = 'i', keys = '<C-x>' },

    -- `g` key
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },

    -- Marks
    { mode = 'n', keys = "'" },
    { mode = 'n', keys = '`' },
    { mode = 'x', keys = "'" },
    { mode = 'x', keys = '`' },

    -- Registers
    { mode = 'n', keys = '"' },
    { mode = 'x', keys = '"' },
    { mode = 'i', keys = '<C-r>' },
    { mode = 'c', keys = '<C-r>' },

    -- Window commands
    { mode = 'n', keys = '<C-w>' },

    -- `z` key
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },
  },

  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
})

require("defer").offload(function()
	-- Show indent lines
	require("mini.indentscope").setup({
		symbol = [[·]], -- Middle Dot (U+00B7)
	})

	-- Per line commenting. Replacement of tpope/vim-commentary
	require("mini.comment").setup({})

	-- Automatic highlighting of word under cursor
	require("mini.cursorword").setup({})

	-- Autopair plugin
	-- Replaces windwp/nvim-autopairs
	require("mini.pairs").setup({})

	-- Surround
	require("mini.surround").setup({})
end)
