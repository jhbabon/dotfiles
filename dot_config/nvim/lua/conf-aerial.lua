return function()
	require("lazy").load(function()
		require("aerial").setup({
			layout = {
				default_direction = "prefer_left",
			},
		})

		require("keychain").set("n", "<leader>ds", [[<cmd>AerialToggle<cr>]], { hint = { "diagnostics", "sidebar" } })
	end)
end
