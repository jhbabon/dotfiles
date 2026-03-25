return {
	cmd = { "efm-langserver" },
	root_markers = { ".git" },
	settings = {
		version = 2,
		rootMarkers = { ".git/" },
	},
	capabilities = {
		workspace = {
			didChangeConfiguration = {
				dynamicRegistration = true,
			},
		},
	},
	init_options = {
		documentFormatting = true,
	},
}
