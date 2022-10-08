return function()
	local mappings = vim.api.nvim_create_augroup("lsp-mappings", { clear = true })
	vim.api.nvim_create_autocmd("LspAttach", {
		group = mappings,
		callback = function(args)
			-- Set mappings
			local buffer = args.buf
			local keychain = require("keychain")
			keychain.set("n", "]e", vim.diagnostic.goto_next, { buffer = buffer, hint = { "lsp", "next diagnostic" } })
			keychain.set(
				"n",
				"[e",
				vim.diagnostic.goto_prev,
				{ buffer = buffer, hint = { "lsp", "previous diagnostic" } }
			)
			keychain.set(
				"n",
				"<leader>li",
				vim.lsp.buf.implementation,
				{ buffer = buffer, hint = { "lsp", "go to implementation" } }
			)
			keychain.set("n", "<leader>lh", vim.lsp.buf.hover, { buffer = buffer, hint = { "lsp", "hover" } })
			keychain.set(
				"n",
				"<leader>ls",
				vim.lsp.buf.signature_help,
				{ buffer = buffer, hint = { "lsp", "signature" } }
			)
			keychain.set("n", "<leader>ln", vim.lsp.buf.rename, { buffer = buffer, hint = { "lsp", "rename" } })
			keychain.set(
				"n",
				"<leader>lg",
				vim.diagnostic.open_float,
				{ buffer = buffer, hint = { "lsp", "line diagnostic" } }
			)
			keychain.set(
				"n",
				"<leader>lc",
				vim.lsp.buf.code_action,
				{ buffer = buffer, hint = { "lsp", "code action" } }
			)
			keychain.set("n", "<leader>lf", vim.lsp.buf.format, { buffer = buffer, hint = { "lsp", "format file" } })
			keychain.set(
				"n",
				"<leader>ly",
				vim.lsp.buf.document_symbol,
				{ buffer = buffer, hint = { "lsp", "document symbols" } }
			)
			keychain.set(
				"n",
				"<leader>lm",
				vim.lsp.buf.incoming_calls,
				{ buffer = buffer, hint = { "lsp", "incoming calls" } }
			)
			keychain.set(
				"n",
				"<leader>lo",
				vim.lsp.buf.outgoing_calls,
				{ buffer = buffer, hint = { "lsp", "outgoing calls" } }
			)
			keychain.set(
				"n",
				"<leader>lt",
				vim.lsp.buf.type_definition,
				{ buffer = buffer, hint = { "lsp", "go to type definition" } }
			)
			keychain.set(
				"n",
				"<leader>ld",
				vim.lsp.buf.definition,
				{ buffer = buffer, hint = { "lsp", "go to definition" } }
			)
			-- Use Trouble for references and definitions
			keychain.set(
				"n",
				"<leader>lr",
				[[<cmd>Trouble lsp_references<cr>]],
				{ buffer = buffer, hint = { "lsp", "references" } }
			)
		end,
	})

	vim.api.nvim_create_autocmd("LspDetach", {
		group = mappings,
		callback = function(args)
			-- Remove mappings
			local buffer = args.buf
			local keychain = require("keychain")
			keychain.del("n", "]e", { buffer = buffer })
			keychain.del("n", "[e", { buffer = buffer })
			keychain.del("n", "<leader>li", { buffer = buffer })
			keychain.del("n", "<leader>lh", { buffer = buffer })
			keychain.del("n", "<leader>ls", { buffer = buffer })
			keychain.del("n", "<leader>ln", { buffer = buffer })
			keychain.del("n", "<leader>lg", { buffer = buffer })
			keychain.del("n", "<leader>lc", { buffer = buffer })
			keychain.del("n", "<leader>lf", { buffer = buffer })
			keychain.del("n", "<leader>ly", { buffer = buffer })
			keychain.del("n", "<leader>lm", { buffer = buffer })
			keychain.del("n", "<leader>lo", { buffer = buffer })
			keychain.del("n", "<leader>lt", { buffer = buffer })
			keychain.del("n", "<leader>ld", { buffer = buffer })
			keychain.del("n", "<leader>lr", { buffer = buffer })
		end,
	})
end
