return function()
	vim.g.minimap_close_filetypes =
	{ "dirbuf", "startify", "netrw", "vim-plug", "fugitive", "git", "which_key", "lspinfo" }
	vim.g.minimap_git_colors = 1
	vim.g.minimap_highlight_search = 1

	local keychain = require("keychain")
	keychain.set("n", "<leader>mt", ":MinimapToggle<cr>", { silent = true, hint = { "minimap", "toggle" } })
	keychain.set("n", "<leader>mr", ":MinimapRefresh<cr>", { silent = true, hint = { "minimap", "refresh" } })
end
