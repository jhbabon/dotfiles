return function()
	require("lazy").load(function()
		require("aerial").setup({
			layout = {
				default_direction = "float",
			},
		})

		require("keychain").set("n", "<leader>ds", [[<cmd>AerialToggle<cr>]], { hint = { "diagnostics", "sidebar" } })
	end)
end
