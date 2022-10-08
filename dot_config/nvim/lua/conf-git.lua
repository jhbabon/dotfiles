return function()
	local keychain = require("keychain")

	-- Fugitive
	keychain.set("n", "<leader>gs", [[:Git<cr>]], { hint = { "git", "status" } })
	keychain.set("n", "<leader>gc", [[:Git commit<cr>]], { hint = { "git", "commit" } })
	keychain.set("n", "<leader>gl", [[:Gclog<cr>]], { hint = { "git", "log" } })
	keychain.set("n", "<leader>gd", [[:Gdiff<cr>]], { hint = { "git", "diff" } })

	-- Gitsigns
	-- remove default keymaps
	require("gitsigns").setup({ keymaps = {} })
	-- add custom keymaps
	keychain.set(
		"n",
		"]c",
		"&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'",
		{ expr = true, hint = { "git", "next hunk" } }
	)
	keychain.set(
		"n",
		"[c",
		"&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'",
		{ expr = true, hint = { "git", "prev hunk" } }
	)

	keychain.set("n", "<leader>hs", [[<cmd>Gitsigns stage_hunk<CR>]], { hint = { "git", "stage hunk" } })
	keychain.vmap("<leader>hs", [[:Gitsigns stage_hunk<CR>]], { hint = { "git", "stage hunk" } })
	keychain.set("n", "<leader>hu", [[<cmd>Gitsigns undo_stage_hunk<CR>]], { hint = { "git", "undo stage hunk" } })
	keychain.set("n", "<leader>hr", [[<cmd>Gitsigns reset_hunk<CR>]], { hint = { "git", "reset hunk" } })
	keychain.vmap("<leader>hr", [[:Gitsigns reset_hunk<CR>]], { hint = { "git", "reset hunk" } })
	keychain.set("n", "<leader>hR", [[<cmd>Gitsigns reset_buffer<CR>]], { hint = { "git", "reset buffer" } })
	keychain.set("n", "<leader>hp", [[<cmd>Gitsigns preview_hunk<CR>]], { hint = { "git", "preview hunk" } })
	keychain.set("n", "<leader>hb", function()
		return require("gitsigns").blame_line({ full = true })
	end, { hint = { "git", "blame" } })
	keychain.set("n", "<leader>hS", [[<cmd>Gitsigns stage_buffer<CR>]], { hint = { "git", "stage buffer" } })
	keychain.set(
		"n",
		"<leader>hU",
		[[<cmd>Gitsigns reset_buffer_index<CR>]],
		{ hint = { "git", "reset buffer index" } }
	)

	-- Text objects
	keychain.map("o", "ih", [[:<C-U>Gitsigns select_hunk<CR>]], { hint = { "git", "" } })
	keychain.map("x", "ih", [[:<C-U>Gitsigns select_hunk<CR>]], { hint = { "git", "" } })
end
