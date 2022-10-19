if vim.g.mylsp_marksman_loaded then
	return
end
vim.g.mylsp_marksman_loaded = true

require("conf-lsp.servers").setup({
	name = "marksman",
	pattern = { "markdown" },
})
