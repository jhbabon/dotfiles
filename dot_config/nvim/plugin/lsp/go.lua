---Configure gopls and efm for go files
-----------------------------------------------------------------------
if vim.g.__lsp_go_plugin__ then
	return
end
vim.g.__lsp_go_plugin__ = true

local layers = require("layers")

layers.set("lsp.go.gopls", function()
	require("lazy-lsp").gopls.setup({ pattern = { "go" } }, function(exec)
		return {
			cmd = exec({ "gopls" }).cmd,
			capabilities = {
				documentFormattingProvider = false,
				documentrangeFormattingProvider = false,
			},
			settings = {
				gopls = {
					-- this prevents GOPROXY=off errors when loading the lsp server
					allowImplicitNetworkAccess = true,
				},
			},
		}
	end)
end)

layers.set("lsp.go.efm", function()
	require("lazy-lsp").efm.setup({ pattern = { "go" } }, function(exec)
		local gofmt = ("%s"):format(exec({ "gofmt" }))
		local goimports = ("%s"):format(exec({ "goimports" }))
		local golangci_lint = ("%s run --color never --out-format tab ${INPUT}"):format(exec({ "golangci-lint" }))

		return {
			settings = {
				rootMarkers = { ".git/" },
				languages = {
					go = {
						{
							formatCommand = gofmt,
							formatStdin = true,
						},
						{
							formatCommand = goimports,
							formatStdin = true,
						},
						{
							prefix = "golangci-lint",
							lintCommand = golangci_lint,
							lintStdin = false,
							lintFormats = { "%.%#:%l:%c %m" },
							rootMarkers = {},
						},
					},
				},
			},
		}
	end)
end)
