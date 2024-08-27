---Configure quicker plugin: https://github.com/stevearc/quicker.nvim
-- Improved UI and workflow for the Neovim quickfix
-----------------------------------------------------------------------
if vim.g.__quicker_plugin__ then
	return
end
vim.g.__quicker_plugin__ = true

require("defer").offload(function()
	require("quicker").setup({
		keys = {
			{
				">",
				function()
					require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
				end,
				desc = "Expand quickfix context",
			},
			{
				"<",
				function()
					require("quicker").collapse()
				end,
				desc = "Collapse quickfix context",
			},
		},
	})

	require("clue")("n", "<leader>q", "quicklist")
	vim.keymap.set("n", "<leader>qt", function()
		require("quicker").toggle()
	end, { desc = "toggle quicklist" })
	vim.keymap.set("n", "<leader>ql", function()
		require("quicker").toggle({ loclist = true })
	end, { desc = "toggle loclist" })
end)
