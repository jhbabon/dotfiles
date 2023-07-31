-- Grepper configuration

if vim.g.__grepper_plugin__ then
	return
end
vim.g.__grepper_plugin__ = true

local tools = require("tools")

vim.keymap.set(
	"n",
	"<leader>sw",
	[[:Grepper -noprompt -cword<cr>]],
	{ desc = tools.desc({ "search", "current word" }) }
)
vim.keymap.set("n", "<leader>sq", [[:GrepperRg<space>]], { silent = false, desc = tools.desc({ "search", "query" }) })

vim.keymap.set(
	"n",
	"<leader>siw",
	[[:Grepper -tool git -noprompt -cword<cr>]],
	{ desc = tools.desc({ "search", "current word with git" }) }
)
vim.keymap.set("n", "<leader>siq", [[:GrepperGit<space>]], { desc = tools.desc({ "search", "query with git" }) })

vim.keymap.set(
	"n",
	"<leader>sgw",
	[[:Grepper -tool grep -noprompt -cword<cr>]],
	{ desc = tools.desc({ "search", "current word with grep" }) }
)
vim.keymap.set("n", "<leader>sgq", [[:GrepperGrep<space>]], { desc = tools.desc({ "search", "query with grep" }) })

vim.g.grepper = {
	tools = { "rg", "git", "grep" },
}

vim.cmd([[packadd vim-grepper]])
