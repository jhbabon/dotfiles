if vim.g.__telescope_plugin__ then
	return
end
vim.g.__telescope_plugin__ = true

require("offload")(function()
	local fz = require("mini.fuzzy")
	fz.setup({})

	require("telescope").setup({
		defaults = {
			generic_sorter = fz.get_telescope_sorter,
		},
	})

	-- TODO: Review more builtin pickers
	local builtin = require("telescope.builtin")
	vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = _G.desc({ "find", "files" }) })
	vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = _G.desc({ "find", "live grep" }) })
	vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = _G.desc({ "find", "buffers" }) })
	vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = _G.desc({ "find", "help tags" }) })
	vim.keymap.set("n", "<leader>fm", builtin.keymaps, { desc = _G.desc({ "find", "help tags" }) })
end)
