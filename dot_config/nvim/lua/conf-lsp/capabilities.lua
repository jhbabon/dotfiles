local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if ok then
	local cmp = cmp_lsp.default_capabilities(capabilities)
	capabilities = vim.tbl_deep_extend("force", capabilities, cmp)
end

return capabilities
