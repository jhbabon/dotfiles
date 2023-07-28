---Configure mason plugin: https://github.com/williamboman/mason.nvim
-- Portable package manager for Neovim that runs everywhere Neovim runs
-----------------------------------------------------------------------
if vim.g.__mason_plugin__ then
	return
end
vim.g.__mason_plugin__ = true

require("mason").setup({
	PATH = "skip",
	ui = { border = "rounded" },
})
