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

local _c = require("clue")("n", "<leader>c", "checkpoint")
vim.keymap.set("n", _c.s, save, { desc = "save current session" })
vim.keymap.set("n", _c.l, load, { desc = "load last session" })

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

local defer = require("defer")
defer.lazy(function()
	-- Show indent lines
	require("mini.indentscope").setup({
		symbol = [[·]], -- Middle Dot (U+00B7)
	})

	-- Automatic highlighting of word under cursor
	require("mini.cursorword").setup({})
end)

defer.very_lazy(function()
	-- Per line commenting. Replacement of tpope/vim-commentary
	require("mini.comment").setup({})

	-- Autopair plugin
	-- Replaces windwp/nvim-autopairs
	require("mini.pairs").setup({})

	-- Surround
	require("mini.surround").setup({})

	-- Move
	require("mini.move").setup({
		mappings = {
			left = "<leader>mh",
			right = "<leader>ml",
			down = "<leader>mj",
			up = "<leader>mk",
			line_left = "<leader>mh",
			line_right = "<leader>ml",
			line_down = "<leader>mj",
			line_up = "<leader>mk",
		},
	})

	-- Bracketed
	require("mini.bracketed").setup()
end)
