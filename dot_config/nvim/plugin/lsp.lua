---Configure main LSP keymaps
-----------------------------------------------------------------------
if vim.g.__lsp_plugin__ then
	return true
end
vim.g.__lsp_plugin__ = true

local _l = require("clue")("n", "<leader>l", "LSP")
local mappings = vim.api.nvim_create_augroup("lsp-mappings", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
	group = mappings,
	callback = function(args)
		-- Set mappings
		local buffer = args.buf
		vim.keymap.set("n", "]e", vim.diagnostic.goto_next, { buffer = buffer, desc = "LSP: next diagnostic" })
		vim.keymap.set("n", "[e", vim.diagnostic.goto_prev, { buffer = buffer, desc = "LSP: previous diagnostic" })
		vim.keymap.set("n", _l.i, vim.lsp.buf.implementation, { buffer = buffer, desc = "LSP: go to implementation" })
		vim.keymap.set("n", _l.h, vim.lsp.buf.hover, { buffer = buffer, desc = "LSP: hover" })
		vim.keymap.set("n", _l.s, vim.lsp.buf.signature_help, { buffer = buffer, desc = "LSP: signature" })
		vim.keymap.set("n", _l.n, vim.lsp.buf.rename, { buffer = buffer, desc = "LSP: rename" })
		vim.keymap.set("n", _l.g, vim.diagnostic.open_float, { buffer = buffer, desc = "LSP: line diagnostic" })
		vim.keymap.set("n", _l.c, vim.lsp.buf.code_action, { buffer = buffer, desc = "LSP: code action" })
		vim.keymap.set("n", _l.f, vim.lsp.buf.format, { buffer = buffer, desc = "LSP: format file" })
		vim.keymap.set("n", _l.y, vim.lsp.buf.document_symbol, { buffer = buffer, desc = "LSP: document symbols" })
		vim.keymap.set("n", _l.m, vim.lsp.buf.incoming_calls, { buffer = buffer, desc = "LSP: incoming calls" })
		vim.keymap.set("n", _l.o, vim.lsp.buf.outgoing_calls, { buffer = buffer, desc = "LSP: outgoing calls" })
		vim.keymap.set("n", _l.t, vim.lsp.buf.type_definition, { buffer = buffer, desc = "LSP: go to type definition" })
		vim.keymap.set("n", _l.d, vim.lsp.buf.definition, { buffer = buffer, desc = "LSP: go to definition" })
		vim.keymap.set("n", _l.r, vim.lsp.buf.references, { buffer = buffer, desc = "LSP: references" })
	end,
})

require("defer").offload(function()
	require("fidget").setup({
		text = {
			spinner = "dots",
		},
	})
end)
