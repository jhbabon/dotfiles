return function()
	-- keep track of the theme names
	local names = {}
	-- keep track of their indexes
	local indexes = {}
	-- keep track of the current index
	local current = 1
	-- use a different key name so the metatable
	-- proxy methods are called
	local function key(k)
		return ("_%s"):format(k)
	end

	local proxy = {
		__index = function(t, k)
			current = indexes[k]
			return rawget(t, key(k))
		end,

		__newindex = function(t, k, value)
			table.insert(names, k)
			for index, name in ipairs(names) do
				indexes[name] = index
			end

			rawset(t, key(k), value)
		end,
	}

	local themes = {}
	setmetatable(themes, proxy)

	function themes.everforest()
		vim.g.everforest_background = "hard"
		vim.g.everforest_enable_italic = true
		vim.g.everforest_better_performance = true

		vim.opt.background = "dark"
		vim.cmd([[colorscheme everforest]])
	end

	function themes.rosepine()
		require("rose-pine").setup({
			dark_variant = "moon",
		})

		-- Mini statusline highlight groups
		local palette = require("rose-pine.palette")
		local mini = {
			MiniStatuslineModeNormal = { bg = palette.rose, fg = palette.base, bold = true },
			MiniStatuslineModeInsert = { bg = palette.foam, fg = palette.base, bold = true },
			MiniStatuslineModeVisual = { bg = palette.iris, fg = palette.base, bold = true },
			MiniStatuslineModeReplace = { bg = palette.pine, fg = palette.base, bold = true },
			MiniStatuslineModeCommand = { bg = palette.love, fg = palette.base, bold = true },
			MiniStatuslineModeOther = { bg = palette.gold, fg = palette.base, bold = true },
			MiniStatuslineInactive = { bg = palette.base, fg = palette.muted },

			MiniStatuslineDevinfo = { bg = palette.overlay, fg = palette.text },
			MiniStatuslineFilename = { bg = palette.base, fg = palette.text },
			MiniStatuslineFileinfo = { bg = palette.base, fg = palette.muted },
		}

		for group, spec in pairs(mini) do
			vim.api.nvim_set_hl(0, group, spec)
		end

		vim.opt.background = "dark"
		vim.cmd([[colorscheme rose-pine]])
	end

	function themes.kanagawa()
		local palette = require("kanagawa.colors").setup({})
		require("kanagawa").setup({})

		-- Mini statusline highlight groups
		local mini = {
			MiniStatuslineModeNormal = { bg = palette.crystalBlue, fg = palette.sumiInk0, bold = true },
			MiniStatuslineModeInsert = { bg = palette.autumnGreen, fg = palette.sumiInk0, bold = true },
			MiniStatuslineModeVisual = { bg = palette.oniViolet, fg = palette.sumiInk0, bold = true },
			MiniStatuslineModeReplace = { bg = palette.autumnRed, fg = palette.sumiInk0, bold = true },
			MiniStatuslineModeCommand = { bg = palette.boatYellow2, fg = palette.sumiInk0, bold = true },
			MiniStatuslineModeOther = { bg = palette.surimiOrange, fg = palette.sumiInk0, bold = true },
			MiniStatuslineInactive = { bg = palette.sumiInk0, fg = palette.fujiGray },

			MiniStatuslineDevinfo = { bg = palette.sumiInk2, fg = palette.fujiWhite },
			MiniStatuslineFilename = { bg = palette.sumiInk1, fg = palette.fujiGray },
			MiniStatuslineFileinfo = { bg = palette.sumiInk2, fg = palette.fujiWhite },
		}

		for group, spec in pairs(mini) do
			vim.api.nvim_set_hl(0, group, spec)
		end

		vim.opt.background = "dark"
		vim.cmd([[colorscheme kanagawa]])
	end

	function themes.github()
		vim.opt.background = "light"
		require("github-theme").setup({
			theme_style = "light",
		})
	end

	function themes.github_dark()
		vim.opt.background = "dark"
		require("github-theme").setup({
			theme_style = "dark",
		})
	end

	-- Cycle through the themes, from current to next
	local function next_theme()
		local len = table.maxn(names)
		local nxt = current + 1
		if nxt > len then
			nxt = 1
		end
		local name = names[nxt]

		themes[name]()
	end

	-- NOTE: I'm using the term "palette" because I have already mappings starting with t (theme) or c (colors)
	require("keychain").set("n", [[<leader>pn]], next_theme, { hint = { "palette", "set next color palette" } })

	-- Setup theme
	themes.github()
end
