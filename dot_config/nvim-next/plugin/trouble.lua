if vim.g.__trouble_plugin__ then
	return
end
vim.g.__trouble_plugin__ = true

require("offload")(function()
	vim.cmd([[packadd trouble.nvim]])
	require("trouble").setup({})

	-- Grepper integration
	vim.api.nvim_create_autocmd("User", {
		pattern = "Grepper",
		callback = function()
			require("trouble").open("quickfix")
		end,
	})

	local function quickfix()
		-- close the list, if it's open
		vim.cmd([[ccl]])
		require("trouble").open("quickfix")
	end

	local function loclist()
		-- close the list, if it's open
		vim.cmd([[lcl]])
		require("trouble").open("loclist")
	end

	local function toggle()
		require("trouble").toggle()
	end

	vim.keymap.set("n", "<leader>dw", function()
		require("trouble").open("workspace_diagnostics")
	end, { desc = _G.desc({ "diagnostics", "workspace diagnostics" }) })

	vim.keymap.set("n", "<leader>dd", function()
		require("trouble").open("document_diagnostics")
	end, { desc = _G.desc({ "diagnostics", "document diagnostics" }) })

	vim.keymap.set("n", "<leader>qf", quickfix, { desc = _G.desc({ "list", "quickfix" }) })

	vim.keymap.set("n", "<leader>ql", loclist, { desc = _G.desc({ "list", "loclist" }) })

	vim.keymap.set("n", "<leader>qt", toggle, { desc = _G.desc({ "trouble", "toggle" }) })
end)
