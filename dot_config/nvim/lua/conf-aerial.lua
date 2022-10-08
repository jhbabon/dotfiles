return function()
	require("aerial").setup({
		default_direction = "prefer_left",
	})

	require("keychain").set("n", "<leader>ds", [[<cmd>AerialToggle<cr>]], { hint = { "diagnostics", "sidebar" } })

	local group = vim.api.nvim_create_augroup("lsp-aerial", { clear = true })
	vim.api.nvim_create_autocmd("LspAttach", {
		group = group,
		callback = function(args)
			local buffer = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)

			require("aerial").on_attach(client, buffer)
		end,
	})
end
