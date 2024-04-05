---Configure main LSP keymaps
-----------------------------------------------------------------------
if vim.g.__lsp_plugin__ then
	return true
end
vim.g.__lsp_plugin__ = true

require("clue")("n", "<leader>l", "LSP")
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
			{ buffer = buffer, desc = "LSP: next diagnostic" }
		)
		vim.keymap.set(
			"n",
			"[e",
			vim.diagnostic.goto_prev,
			{ buffer = buffer, desc = "LSP: previous diagnostic" }
		)
		vim.keymap.set(
			"n",
			"<leader>li",
			vim.lsp.buf.implementation,
			{ buffer = buffer, desc = "LSP: go to implementation" }
		)
		vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, { buffer = buffer, desc = "LSP: hover" })
		vim.keymap.set(
			"n",
			"<leader>ls",
			vim.lsp.buf.signature_help,
			{ buffer = buffer, desc = "LSP: signature" }
		)
		vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, { buffer = buffer, desc = "LSP: rename" })
		vim.keymap.set(
			"n",
			"<leader>lg",
			vim.diagnostic.open_float,
			{ buffer = buffer, desc = "LSP: line diagnostic" }
		)
		vim.keymap.set(
			"n",
			"<leader>lc",
			vim.lsp.buf.code_action,
			{ buffer = buffer, desc = "LSP: code action" }
		)
		vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { buffer = buffer, desc = "LSP: format file" })
		vim.keymap.set(
			"n",
			"<leader>ly",
			vim.lsp.buf.document_symbol,
			{ buffer = buffer, desc = "LSP: document symbols" }
		)
		vim.keymap.set(
			"n",
			"<leader>lm",
			vim.lsp.buf.incoming_calls,
			{ buffer = buffer, desc = "LSP: incoming calls" }
		)
		vim.keymap.set(
			"n",
			"<leader>lo",
			vim.lsp.buf.outgoing_calls,
			{ buffer = buffer, desc = "LSP: outgoing calls" }
		)
		vim.keymap.set(
			"n",
			"<leader>lt",
			vim.lsp.buf.type_definition,
			{ buffer = buffer, desc = "LSP: go to type definition" }
		)
		vim.keymap.set(
			"n",
			"<leader>ld",
			vim.lsp.buf.definition,
			{ buffer = buffer, desc = "LSP: go to definition" }
		)
		-- Use Trouble for references and definitions
		vim.keymap.set(
			"n",
			"<leader>lr",
			[[<cmd>Trouble lsp_references<cr>]],
			{ buffer = buffer, desc = "LSP: references" }
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
