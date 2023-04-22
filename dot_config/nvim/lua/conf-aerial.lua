return function()
	require("lazy").load(function()
		require("aerial").setup({
			layout = {
				default_direction = "float",
			},
			filter_kind = false,
			float = {
				relative = "win",
			},
			close_on_select = true,
		})

		require("keychain").set("n", "<leader>ds", [[<cmd>AerialToggle<cr>]], { hint = { "diagnostics", "sidebar" } })
	end)
end
