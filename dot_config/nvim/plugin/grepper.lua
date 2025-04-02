---Configure grepper plugin: https://github.com/mhinz/vim-grepper
-- Helps you win at grep.
-----------------------------------------------------------------------
if vim.g.__grepper_plugin__ then
	return
end
vim.g.__grepper_plugin__ = true

require("defer").very_lazy(function()
	local clue = require("clue")

	local _s = clue("n", "<leader>s", "search")
	vim.keymap.set("n", _s.w, [[:Grepper -noprompt -cword<cr>]], { desc = "search current word" })
	vim.keymap.set("n", _s.q, [[:GrepperRg<space>]], { silent = false, desc = "search query" })

	local _si = clue("n", "<leader>si", "search with git")
	vim.keymap.set("n", _si.w, [[:Grepper -tool git -noprompt -cword<cr>]], { desc = "search current word with git" })
	vim.keymap.set("n", _si.q, [[:GrepperGit<space>]], { desc = "search query with git" })

	local _sg = clue("n", "<leader>sg", "search with grep")
	vim.keymap.set("n", _sg.w, [[:Grepper -tool grep -noprompt -cword<cr>]], { desc = "search current word with grep" })
	vim.keymap.set("n", _sg.q, [[:GrepperGrep<space>]], { desc = "search query with grep" })

	vim.g.grepper = {
		open = true,
		quickfix = true,
		tools = { "rg", "git", "grep" },
	}

	vim.cmd([[packadd vim-grepper]])
end)
