-- Setup null-ls
return function()
	local capabilities = require("conf-lsp.capabilities")
	local masonry = require("conf-lsp.masonry")
	local bins = require("conf-lsp.bins")

	local null_ls = require("null-ls")
	local formatting = null_ls.builtins.formatting
	local diagnostics = null_ls.builtins.diagnostics
	local code_actions = null_ls.builtins.code_actions

	masonry.ensure_tools({
		{ name = "golangci-lint", version = "v1.49.0" },
		{ name = "goimports", version = "latest" },
		{ name = "stylua" },
	})

	local sources = {
		-- javascript & typescript
		formatting.eslint_d,
		diagnostics.eslint_d,
		code_actions.eslint_d,

		-- golang
		formatting.goimports.with({ command = masonry.get_path("goimports") }),
		diagnostics.golangci_lint.with({ command = masonry.get_path("golangci-lint") }),

		-- lua
		formatting.stylua,

		-- git
		code_actions.gitsigns,
	}

	if bins.rubocop then
		table.insert(sources, formatting.rubocop.with({ command = "bin/rubocop" }))
		table.insert(sources, diagnostics.rubocop.with({ command = "bin/rubocop" }))
	end

	null_ls.setup({
		sources = sources,
		capabilities = capabilities,
	})
end
