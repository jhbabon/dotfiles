---Configure markdown.nvim plugin: https://github.com/MeanderingProgrammer/markdown.nvim
-- Plugin to improve viewing Markdown files in Neovim
-----------------------------------------------------------------------
if vim.g.__markdown_plugin__ then
	return
end
vim.g.__markdown_plugin__ = true

require("defer").offload(function()
	require("render-markdown").setup({})
end)
