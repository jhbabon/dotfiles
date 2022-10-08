return function()
	require("trouble").setup({})

	local keychain = require("keychain")

	keychain.set(
		"n",
		"<leader>dw",
		[[<cmd>Trouble workspace_diagnostics<cr>]],
		{ hint = { "diagnostics", "workspace diagnostics" } }
	)
	keychain.set(
		"n",
		"<leader>dd",
		[[<cmd>Trouble document_diagnostics<cr>]],
		{ hint = { "diagnostics", "document diagnostics" } }
	)
	keychain.set("n", "<leader>qf", [[<cmd>Trouble quickfix<cr>]], { hint = { "list", "quickfix" } })
	keychain.set("n", "<leader>ql", [[<cmd>Trouble loclist<cr>]], { hint = { "list", "loclist" } })
	keychain.set("n", "<leader>tt", [[<cmd>TroubleToggle<cr>]], { hint = { "trouble", "toggle" } })
end
