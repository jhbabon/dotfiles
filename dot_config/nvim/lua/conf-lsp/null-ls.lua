-- Setup null-ls
return function()
	local null_ls = require("null-ls")
	local formatting = null_ls.builtins.formatting
	local diagnostics = null_ls.builtins.diagnostics
	local code_actions = null_ls.builtins.code_actions
	local completion = null_ls.builtins.completion

	local capabilities = require("conf-lsp.capabilities")
	local binaries = require("binaries")

	local resolver = binaries.prepare_many({
		{ { name = "golangci-lint", version = "v1.49.0" } },
		{ { name = "goimports", version = "latest" } },
		{ { name = "stylua" } },
		{ { name = "rubocop" }, { binaries.lookups.local_bin } },
	})

	resolver:resolve(function(tools)
		local sources = {
			-- javascript & typescript
			formatting.eslint_d,
			diagnostics.eslint_d,
			code_actions.eslint_d,

			-- git
			code_actions.gitsigns,

			-- snippets
			completion.luasnip,
		}

		-- golang
		tools["golangci-lint"]:and_then(function(golangci_lint)
			table.insert(sources, diagnostics.golangci_lint.with({ command = golangci_lint.cmd.string() }))
		end)
		tools.goimports:and_then(function(goimports)
			table.insert(sources, formatting.goimports.with({ command = goimports.cmd.string() }))
		end)

		-- lua
		tools.stylua:and_then(function(stylua)
			table.insert(sources, formatting.stylua.with({ command = stylua.cmd.string() }))
		end)

		-- ruby
		tools.rubocop:and_then(function(rubocop)
			table.insert(sources, diagnostics.rubocop.with({ command = rubocop.cmd.string() }))
		end)

		null_ls.setup({
			sources = sources,
			capabilities = capabilities,
		})
	end)
end
