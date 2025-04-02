---Setup  mini.clue
-- This setup is done in an after plugin and in an offload
-- block to delay it as much as possible. The name of the file
-- should help loading this as the last plugin, enqueueing
-- the offload block (UIEnter event) the last one.
-- This way we can get all the "clues" from all the plugins.
-----------------------------------------------------------------------
if vim.g.__miniclue_plugin__ then
	return
end
vim.g.__miniclue_plugin__ = true

require("defer").very_lazy(function()
	local miniclue = require("mini.clue")
	miniclue.setup({
		triggers = {
			-- Leader triggers
			{ mode = "n", keys = "<Leader>" },
			{ mode = "x", keys = "<Leader>" },

			-- Built-in completion
			{ mode = "i", keys = "<C-x>" },

			-- `g` key
			{ mode = "n", keys = "g" },
			{ mode = "x", keys = "g" },

			-- Marks
			{ mode = "n", keys = "'" },
			{ mode = "n", keys = "`" },
			{ mode = "x", keys = "'" },
			{ mode = "x", keys = "`" },

			-- Registers
			{ mode = "n", keys = '"' },
			{ mode = "x", keys = '"' },
			{ mode = "i", keys = "<C-r>" },
			{ mode = "c", keys = "<C-r>" },

			-- Window commands
			{ mode = "n", keys = "<C-w>" },

			-- `z` key
			{ mode = "n", keys = "z" },
			{ mode = "x", keys = "z" },

			-- Move
			{ mode = "n", keys = "<Leader>m" },
			{ mode = "x", keys = "<Leader>m" },

			-- bracketed
			{ mode = "n", keys = "]" },
			{ mode = "n", keys = "[" },

			-- `c` key
			{ mode = "n", keys = "c" },
			{ mode = "x", keys = "c" },
		},

		clues = {
			-- Move submode
			{ mode = "n", keys = "<Leader>mh", postkeys = "<Leader>m" },
			{ mode = "n", keys = "<Leader>mj", postkeys = "<Leader>m" },
			{ mode = "n", keys = "<Leader>mk", postkeys = "<Leader>m" },
			{ mode = "n", keys = "<Leader>ml", postkeys = "<Leader>m" },
			{ mode = "x", keys = "<Leader>mh", postkeys = "<Leader>m" },
			{ mode = "x", keys = "<Leader>mj", postkeys = "<Leader>m" },
			{ mode = "x", keys = "<Leader>mk", postkeys = "<Leader>m" },
			{ mode = "x", keys = "<Leader>ml", postkeys = "<Leader>m" },

			-- Bracketed submode: buffers
			{ mode = "n", keys = "]b",         postkeys = "]" },
			{ mode = "n", keys = "[b",         postkeys = "[" },

			-- Bracketed submode: windows
			{ mode = "n", keys = "]w",         postkeys = "]" },
			{ mode = "n", keys = "[w",         postkeys = "[" },

			miniclue.gen_clues.builtin_completion(),
			miniclue.gen_clues.g(),
			miniclue.gen_clues.marks(),
			miniclue.gen_clues.registers(),
			miniclue.gen_clues.windows({
				submode_move = true,
				submode_resize = true,
			}),
			miniclue.gen_clues.z(),

			-- Clues gathered across plugins
			require("clue").mini(),
		},

		window = {
			config = {
				width = "auto",
			},
		},
	})

	vim.api.nvim_set_hl(0, "MiniClueNextKey", { link = "NormalFloat" })
end)
