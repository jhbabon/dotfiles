return function()
	require("lazy").load(function()
		-- Fugitive
		local keys = require("keychain")
		keys.set("n", "<leader>gs", [[:Git<cr>]], { hint = { "git", "status" } })
		keys.set("n", "<leader>gc", [[:Git commit<cr>]], { hint = { "git", "commit" } })
		keys.set("n", "<leader>gl", [[:Gclog<cr>]], { hint = { "git", "log" } })
		keys.set("n", "<leader>gd", [[:Gdiff<cr>]], { hint = { "git", "diff" } })

		-- Gitsigns
		-- remove default keymaps
		require("gitsigns").setup({ keymaps = {} })

		-- add custom keymaps
		local group = vim.api.nvim_create_augroup("gitsigns-mappings", { clear = true })
		vim.api.nvim_create_autocmd("BufEnter", {
			group = group,
			callback = function(args)
				local keychain = require("keychain")
				local gitsigns = require("gitsigns")
				local buffer = args.buf

				if not vim.wo.diff then
					keychain.set("n", "]c", gitsigns.next_hunk, { buffer = buffer, hint = { "git", "next hunk" } })
					keychain.set("n", "[c", gitsigns.prev_hunk, { buffer = buffer, hint = { "git", "prev hunk" } })
				end

				keychain.set(
					"n",
					"<leader>hs",
					gitsigns.stage_hunk,
					{ buffer = buffer, hint = { "git", "stage hunk" } }
				)
				keychain.set(
					"v",
					"<leader>hs",
					gitsigns.stage_hunk,
					{ buffer = buffer, hint = { "git", "stage hunk" } }
				)
				keychain.set(
					"n",
					"<leader>hu",
					gitsigns.undo_stage_hunk,
					{ buffer = buffer, hint = { "git", "undo stage hunk" } }
				)
				keychain.set(
					"n",
					"<leader>hr",
					gitsigns.reset_hunk,
					{ buffer = buffer, hint = { "git", "reset hunk" } }
				)
				keychain.set(
					"v",
					"<leader>hr",
					gitsigns.reset_hunk,
					{ buffer = buffer, hint = { "git", "reset hunk" } }
				)
				keychain.set(
					"n",
					"<leader>hR",
					gitsigns.reset_buffer,
					{ buffer = buffer, hint = { "git", "reset buffer" } }
				)
				keychain.set(
					"n",
					"<leader>hp",
					gitsigns.preview_hunk,
					{ buffer = buffer, hint = { "git", "preview hunk" } }
				)

				local function blame()
					return gitsigns.blame_line({ full = true })
				end

				keychain.set("n", "<leader>hb", blame, { buffer = buffer, hint = { "git", "blame" } })
				keychain.set(
					"n",
					"<leader>hB",
					gitsigns.toggle_current_line_blame,
					{ buffer = buffer, hint = { "git", "toggle current line blame" } }
				)

				keychain.set(
					"n",
					"<leader>hS",
					gitsigns.stage_buffer,
					{ buffer = buffer, hint = { "git", "stage buffer" } }
				)
				keychain.set(
					"n",
					"<leader>hU",
					gitsigns.reset_buffer_index,
					{ buffer = buffer, hint = { "git", "reset buffer index" } }
				)

				local function highlight()
					gitsigns.toggle_numhl()
					gitsigns.toggle_linehl()
					gitsigns.toggle_word_diff()
				end

				keychain.set("n", "<leader>hh", highlight, { buffer = buffer, hint = { "git", "highlight changes" } })

				-- Text objects
				keychain.map("o", "ih", [[:<C-U>Gitsigns select_hunk<CR>]], { buffer = buffer, hint = { "git", "" } })
				keychain.map("x", "ih", [[:<C-U>Gitsigns select_hunk<CR>]], { buffer = buffer, hint = { "git", "" } })
			end,
		})
	end)
end
