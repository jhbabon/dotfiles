return function()
	require("lazy").load(function()
		require("trouble").setup({})

		local function quickfix()
			-- close the list, if is open
			vim.api.nvim_exec([[ccl]], false)
			require("trouble").open("quickfix")
		end

		local function loclist()
			-- close the list, if is open
			vim.api.nvim_exec([[lcl]], false)
			require("trouble").open("loclist")
		end

		local function toggle()
			require("trouble").toggle()
		end

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
		keychain.set("n", "<leader>qf", quickfix, { hint = { "list", "quickfix" } })
		keychain.set("n", "<leader>ql", loclist, { hint = { "list", "loclist" } })
		keychain.set("n", "<leader>qt", toggle, { hint = { "trouble", "toggle" } })
	end)
end
