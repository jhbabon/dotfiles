if vim.g.__yaml_ftplugin__ then
	return
end
vim.g.__yaml_ftplugin__ = true

require("lsp").enable("yamlls")
