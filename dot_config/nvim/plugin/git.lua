---Configure fugitive plugin: https://github.com/tpope/vim-fugitive
-- A Git wrapper so awesome, it should be illegal
--
---Configure diffview plugin: https://github.com/sindrets/diffview.nvim
-- Single tabpage interface for easily cycling through diffs
-- for all modified files for any git rev.
-----------------------------------------------------------------------
if vim.g.__git_plugin__ then
	return
end
vim.g.__git_plugin__ = true

require("defer").offload(function()
	require("diffview").setup({})

	local _g = require("clue")("n", "<leader>g", "git")
	vim.keymap.set("n", _g.s, [[:Git<cr>]], { desc = "git status" })
	vim.keymap.set("n", _g.c, [[:Git commit<cr>]], { desc = "git commit" })
	vim.keymap.set("n", _g.d, [[:DiffviewOpen<cr>]], { desc = "git diff" })
end)
