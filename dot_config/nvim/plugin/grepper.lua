---Configure grepper plugin: https://github.com/mhinz/vim-grepper
-- Helps you win at grep.
-----------------------------------------------------------------------
if vim.g.__grepper_plugin__ then
	return
end
vim.g.__grepper_plugin__ = true

require("defer").offload(function()
	local clue = require("clue")

	clue("n", "<leader>s", "search")
	vim.keymap.set("n", "<leader>sw", [[:Grepper -noprompt -cword<cr>]], { desc = "search current word" })
	vim.keymap.set("n", "<leader>sq", [[:GrepperRg<space>]], { silent = false, desc = "search query" })

	clue("n", "<leader>si", "search with git")
	vim.keymap.set(
		"n",
		"<leader>siw",
		[[:Grepper -tool git -noprompt -cword<cr>]],
		{ desc = "search current word with git" }
	)
	vim.keymap.set("n", "<leader>siq", [[:GrepperGit<space>]], { desc = "search query with git" })

	clue("n", "<leader>sg", "search with grep")
	vim.keymap.set(
		"n",
		"<leader>sgw",
		[[:Grepper -tool grep -noprompt -cword<cr>]],
		{ desc = "search current word with grep" }
	)
	vim.keymap.set("n", "<leader>sgq", [[:GrepperGrep<space>]], { desc = "search query with grep" })

	vim.g.grepper = {
		open = true,
		quickfix = true,
		tools = { "rg", "git", "grep" },
	}

	vim.cmd([[packadd vim-grepper]])
end)
