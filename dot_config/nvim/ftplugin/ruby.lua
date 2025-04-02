if vim.g.__ruby_ftplugin__ then
	return
end
vim.g.__ruby_ftplugin__ = true

vim.lsp.config("efm", {
	filetypes = { "ruby" },
	settings = {
		languages = {
			ruby = {
				{
					prefix = "rubocop",
					lintCommand = "bundle exec rubocop --format emacs --stdin ${INPUT}",
					lintStdin = true,
					lintFormats = { "%f:%l:%c: %t: %m" },
					rootMarkers = { "Gemfile" },
				},
			},
		},
	},
})

require("lsp").enable({ "sorbet", "efm" })
