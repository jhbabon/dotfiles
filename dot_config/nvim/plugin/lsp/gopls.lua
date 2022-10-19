if vim.g.mylsp_gopls_loaded then
	return
end
vim.g.mylsp_gopls_loaded = true

local capabilities = vim.tbl_extend("force", require("conf-lsp.capabilities"), {
	-- disable formatting
	documentFormattingProvider = false,
	documentrangeFormattingProvider = false,
})

require("conf-lsp.servers").setup({
	name = "gopls",
	pattern = { "go" },
	capabilities = capabilities,
	settings = {
		gopls = {
			-- this prevents GOPROXY=off errors when loading the lsp server
			allowImplicitNetworkAccess = true,
		},
	},
})
