return {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_markers = { "go.work", "go.mod", ".git" },
	capabilities = {
		documentFormattingProvider = false,
		documentrangeFormattingProvider = false,
	},
}
