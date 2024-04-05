---Configure trouble plugin: https://github.com/folke/trouble.nvim
-- A pretty diagnostics, references, telescope results, quickfix
-- and location list to help you solve all the trouble your code is causing
-----------------------------------------------------------------------
if vim.g.__trouble_plugin__ then
	return
end
vim.g.__trouble_plugin__ = true

require("defer").offload(function()
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

	local clue = require("clue")

	clue("n", "<leader>d", "diagnostics")
	vim.keymap.set("n", "<leader>dw", function()
		require("trouble").open("workspace_diagnostics")
	end, { desc = "workspace diagnostics" })
	vim.keymap.set("n", "<leader>dd", function()
		require("trouble").open("document_diagnostics")
	end, { desc = "document diagnostics" })

	clue("n", "<leader>q", "list")
	vim.keymap.set("n", "<leader>qf", quickfix, { desc = "quickfix" })
	vim.keymap.set("n", "<leader>ql", loclist, { desc = "loclist" })

	clue("n", "<leader>q", "trouble")
	vim.keymap.set("n", "<leader>qt", toggle, { desc = "toggle trouble" })
end)
