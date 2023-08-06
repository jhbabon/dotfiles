---Configure telescope plugin: https://github.com/nvim-telescope/telescope.nvim
-- Find, Filter, Preview, Pick. All lua, all the time
-----------------------------------------------------------------------
if vim.g.__telescope_plugin__ then
	return
end
vim.g.__telescope_plugin__ = true

require("defer").offload(function()
	local fz = require("mini.fuzzy")
	fz.setup({})

	require("telescope").setup({
		defaults = {
			generic_sorter = fz.get_telescope_sorter,
		},
		pickers = {
			find_files = {
				find_command = {
					"rg",
					"--files",
					"--hidden",
					"--ignore",
					"--follow",
					"--glob=!**/.git/*",
					"--glob=!**/node_modules/*",
				},
			},
		},
	})

	local function themed(fn)
		return function()
			fn(require("telescope.themes").get_dropdown())
		end
	end

	-- TODO: Review more builtin pickers
	local builtin = require("telescope.builtin")
	vim.keymap.set("n", "<leader>ff", themed(builtin.find_files), { desc = _G.desc({ "find", "files" }) })
	vim.keymap.set("n", "<leader>fb", themed(builtin.buffers), { desc = _G.desc({ "find", "buffers" }) })
	vim.keymap.set("n", "<leader>fh", themed(builtin.help_tags), { desc = _G.desc({ "find", "help tags" }) })
	vim.keymap.set("n", "<leader>km", themed(builtin.keymaps), { desc = _G.desc({ "find", "keymaps" }) })

	vim.keymap.set(
		"n",
		"<leader>stw",
		themed(builtin.grep_string),
		{ desc = _G.desc({ "search", "current word with telescope" }) }
	)
	vim.keymap.set(
		"n",
		"<leader>stq",
		themed(builtin.live_grep),
		{ desc = _G.desc({ "search", "query with telescope" }) }
	)
end)
