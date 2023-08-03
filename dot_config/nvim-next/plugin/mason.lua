if vim.g.__mason_plugin__ then
	return
end
vim.g.__mason_plugin__ = true

require("mason").setup({
	PATH = "skip",
	ui = { border = "rounded" },
})
