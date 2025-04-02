-- make sure tabs are always expanded as tabs
vim.bo.expandtab = false

if vim.g.__go_ftplugin__ then
	return
end
vim.g.__go_ftplugin__ = true

vim.lsp.config("efm", {
	filetypes = { "go" },
	settings = {
		languages = {
			go = {
				{
					formatCommand = "gofmt",
					formatStdin = true,
				},
				{
					formatCommand = "goimports",
					formatStdin = true,
				},
				{
					prefix = "golangci-lint",
					lintCommand = "golangci-lint run --color never --out-format tab ${INPUT}",
					lintStdin = false,
					lintFormats = { "%.%#:%l:%c %m" },
					rootMarkers = {},
				},
			},
		},
	},
})

require("lsp").enable({ "gopls", "efm" })
