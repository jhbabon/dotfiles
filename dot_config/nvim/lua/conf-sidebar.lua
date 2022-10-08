return function()
	require("sidebar-nvim").setup({
		open = false,
		sections = { "symbols", "diagnostics" },
	})

	local keychain = require("keychain")
	keychain.set("n", "<leader>ds", [[:SidebarNvimToggle<cr>]], { hint = { "diagnostics", "sidebar" } })
end
