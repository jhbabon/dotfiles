---Configure marksman for markdown files
-----------------------------------------------------------------------
if vim.g.__lsp_markdown_plugin__ then
	return
end
vim.g.__lsp_markdown_plugin__ = true

require("lazy-lsp").marksman.setup({ pattern = { "markdown" } }, function(_)
	return {}
end)
