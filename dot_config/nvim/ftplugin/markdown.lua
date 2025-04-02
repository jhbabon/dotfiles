if vim.g.__markdown_ftplugin__ then
	return
end
vim.g.__markdown_ftplugin__ = true

require("lsp").enable("marksman")
