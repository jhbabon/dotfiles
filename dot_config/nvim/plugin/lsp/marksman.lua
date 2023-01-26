if vim.g.mylsp_marksman_loaded then
	return
end
vim.g.mylsp_marksman_loaded = true

require("conf-lsp.server").setup({
	name = "marksman",
	pattern = { "markdown" },
})
