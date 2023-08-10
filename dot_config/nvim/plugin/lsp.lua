---Configure main LSP keymaps
-----------------------------------------------------------------------
if vim.g.__lsp_plugin__ then
	return true
end
vim.g.__lsp_plugin__ = true

local mappings = vim.api.nvim_create_augroup("lsp-mappings", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
	group = mappings,
	callback = function(args)
		-- Set mappings
		local buffer = args.buf
		vim.keymap.set(
			"n",
			"]e",
			vim.diagnostic.goto_next,
			{ buffer = buffer, desc = _G.desc({ "lsp", "next diagnostic" }) }
		)
		vim.keymap.set(
			"n",
			"[e",
			vim.diagnostic.goto_prev,
			{ buffer = buffer, desc = _G.desc({ "lsp", "previous diagnostic" }) }
		)
		vim.keymap.set(
			"n",
			"<leader>li",
			vim.lsp.buf.implementation,
			{ buffer = buffer, desc = _G.desc({ "lsp", "go to implementation" }) }
		)
		vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, { buffer = buffer, desc = _G.desc({ "lsp", "hover" }) })
		vim.keymap.set(
			"n",
			"<leader>ls",
			vim.lsp.buf.signature_help,
			{ buffer = buffer, desc = _G.desc({ "lsp", "signature" }) }
		)
		vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, { buffer = buffer, desc = _G.desc({ "lsp", "rename" }) })
		vim.keymap.set(
			"n",
			"<leader>lg",
			vim.diagnostic.open_float,
			{ buffer = buffer, desc = _G.desc({ "lsp", "line diagnostic" }) }
		)
		vim.keymap.set(
			"n",
			"<leader>lc",
			vim.lsp.buf.code_action,
			{ buffer = buffer, desc = _G.desc({ "lsp", "code action" }) }
		)
		vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { buffer = buffer, desc = _G.desc({ "lsp", "format file" }) })
		vim.keymap.set(
			"n",
			"<leader>ly",
			vim.lsp.buf.document_symbol,
			{ buffer = buffer, desc = _G.desc({ "lsp", "document symbols" }) }
		)
		vim.keymap.set(
			"n",
			"<leader>lm",
			vim.lsp.buf.incoming_calls,
			{ buffer = buffer, desc = _G.desc({ "lsp", "incoming calls" }) }
		)
		vim.keymap.set(
			"n",
			"<leader>lo",
			vim.lsp.buf.outgoing_calls,
			{ buffer = buffer, desc = _G.desc({ "lsp", "outgoing calls" }) }
		)
		vim.keymap.set(
			"n",
			"<leader>lt",
			vim.lsp.buf.type_definition,
			{ buffer = buffer, desc = _G.desc({ "lsp", "go to type definition" }) }
		)
		vim.keymap.set(
			"n",
			"<leader>ld",
			vim.lsp.buf.definition,
			{ buffer = buffer, desc = _G.desc({ "lsp", "go to definition" }) }
		)
		-- Use Trouble for references and definitions
		vim.keymap.set(
			"n",
			"<leader>lr",
			[[<cmd>Trouble lsp_references<cr>]],
			{ buffer = buffer, desc = _G.desc({ "lsp", "references" }) }
		)
	end,
})

require("defer").offload(function()
	require("fidget").setup({
		text = {
			spinner = "dots",
		},
	})
end)
