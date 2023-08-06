if vim.g.__grepper_plugin__ then
	return
end
vim.g.__grepper_plugin__ = true

vim.keymap.set("n", "<leader>sw", [[:Grepper -noprompt -cword<cr>]], { desc = _G.desc({ "search", "current word" }) })
vim.keymap.set("n", "<leader>sq", [[:GrepperRg<space>]], { silent = false, desc = _G.desc({ "search", "query" }) })

vim.keymap.set(
	"n",
	"<leader>siw",
	[[:Grepper -tool git -noprompt -cword<cr>]],
	{ desc = _G.desc({ "search", "current word with git" }) }
)
vim.keymap.set("n", "<leader>siq", [[:GrepperGit<space>]], { desc = _G.desc({ "search", "query with git" }) })

vim.keymap.set(
	"n",
	"<leader>sgw",
	[[:Grepper -tool grep -noprompt -cword<cr>]],
	{ desc = _G.desc({ "search", "current word with grep" }) }
)
vim.keymap.set("n", "<leader>sgq", [[:GrepperGrep<space>]], { desc = _G.desc({ "search", "query with grep" }) })

vim.g.grepper = {
	open = false,
	tools = { "rg", "git", "grep" },
}

vim.cmd([[packadd vim-grepper]])
