---Configure marksman for markdown files
-----------------------------------------------------------------------
if vim.g.__lsp_markdown_plugin__ then
	return
end
vim.g.__lsp_markdown_plugin__ = true

require("layers").set("lsp.markdown.marksman", function()
	require("lazy-lsp").marksman.setup({ pattern = { "markdown" } }, function(_)
		return {}
	end)
end)
