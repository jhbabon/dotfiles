if vim.g.mylsp_gopls_loaded then
	return
end
vim.g.mylsp_gopls_loaded = true

local capabilities = vim.tbl_extend("force", require("conf-lsp.capabilities"), {
	-- disable formatting
	documentFormattingProvider = false,
	documentrangeFormattingProvider = false,
})

require("conf-lsp.server").setup({
	name = "gopls",
	pattern = { "go" },
	hook = function(_)
		return {
			capabilities = capabilities,
			settings = {
				gopls = {
					-- this prevents GOPROXY=off errors when loading the lsp server
					allowImplicitNetworkAccess = true,
				},
			},
		}
	end,
})
