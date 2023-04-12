return function()
	require("lazy").load(function()
		vim.g.minimap_close_filetypes =
			{ "dirbuf", "startify", "netrw", "vim-plug", "fugitive", "git", "which_key", "lspinfo" }
		vim.g.minimap_git_colors = 1
		vim.g.minimap_highlight_search = 1

		local add = require("fp").once(function()
			vim.cmd.packadd([[minimap.vim]])
		end)

		local function toggle()
			add()

			vim.cmd([[MinimapToggle]])
		end

		local function refresh()
			add()

			vim.cmd([[MinimapRefresh]])
		end

		local keychain = require("keychain")
		keychain.set("n", "<leader>mt", toggle, { silent = true, hint = { "minimap", "toggle" } })
		keychain.set("n", "<leader>mr", refresh, { silent = true, hint = { "minimap", "refresh" } })
	end)
end
