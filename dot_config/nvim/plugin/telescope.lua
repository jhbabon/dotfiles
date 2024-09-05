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
	local clue = require("clue")
	local builtin = require("telescope.builtin")
	local _f = clue("n", "<leader>f", "find")
	vim.keymap.set("n", _f.f, themed(builtin.find_files), { desc = "find files" })
	vim.keymap.set("n", _f.b, themed(builtin.buffers), { desc = "find buffers" })
	vim.keymap.set("n", _f.h, themed(builtin.help_tags), { desc = "find help tags" })

	local _k = clue("n", "<leader>k", "keymaps")
	vim.keymap.set("n", _k.m, themed(builtin.keymaps), { desc = "find keymaps" })

	local _st = clue("n", "<leader>st", "search with telescope")
	vim.keymap.set("n", _st.w, themed(builtin.grep_string), { desc = "search current word with telescope" })
	vim.keymap.set("n", _st.q, themed(builtin.live_grep), { desc = "search query with telescope" })
end)
