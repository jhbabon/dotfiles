if vim.g.__rust_ftplugin__ then
	return
end
vim.g.__rust_ftplugin__ = true

require("lsp").enable("rust-analyzer")
