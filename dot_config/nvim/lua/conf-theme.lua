return function()
	-- everforest
	-- vim.g.everforest_background = "hard"
	-- vim.g.everforest_enable_italic = true
	-- vim.g.everforest_better_performance = true

	-- kanagawa
	local palette = require("kanagawa.colors").setup({})
	require("kanagawa").setup({})

	-- rose-pine colorscheme
	-- require("rose-pine").setup({
	--   dark_variant = "moon",
	-- })
	-- local palette = require("rose-pine.palette")

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
