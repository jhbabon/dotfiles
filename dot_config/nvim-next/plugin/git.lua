if vim.g.__git_plugin__ then
	return
end
vim.g.__git_plugin__ = true

vim.cmd([[packadd neogit]])

require("neogit").setup({})
