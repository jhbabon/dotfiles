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
