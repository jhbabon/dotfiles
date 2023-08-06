---Configure statusline and colorscheme
-- Statusline is set with lualine: https://github.com/nvim-lualine/lualine.nvim
--   A blazing fast and easy to configure neovim statusline plugin written in pure lua
-- Colorscheme is set with rose-pine: https://github.com/rose-pine/neovim
--   Soho vibes for Neovim
-----------------------------------------------------------------------
if vim.g.__theme_plugin__ then
	return
end
vim.g.__theme_plugin__ = true

require("rose-pine").setup({
	dark_variant = "moon",
	disable_italics = true,
	highlight_groups = {
		Comment = { fg = "muted", italic = true },
		Keyword = { fg = "pine", italic = true },
		htmlItalic = { italic = true },
		mkdCode = { fg = "foam", italic = true },
		["@text.emphasis"] = { italic = true },
		["@parameter"] = { fg = "iris", italic = true },
	},
})

vim.opt.background = "dark"
vim.cmd([[colorscheme rose-pine]])

-- Dirbuf customizations
local dirbuf = {
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = {
			{
				"filename",
				newfile_status = true,
				path = 1,
			},
		},
		lualine_x = {
			{
				"filetype",
				icons_enabled = false,
			},
		},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	filetypes = { "dirbuf" },
}

require("lualine").setup({
	options = {
		theme = "rose-pine",
		globalstatus = true,
		disabled_filetypes = {
			winbar = {
				"Trouble",
				"dirbuf",
				"gitcommit",
				"minimap",
				"DiffviewFiles",
				"fugitive",
			},
		},
	},
	extensions = { "trouble", "fugitive", dirbuf },
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff" },
		lualine_c = { "diagnostics" },
	},
	winbar = {
		lualine_b = {
			{
				"filename",
				newfile_status = true,
				path = 1,
			},
		},
	},
	inactive_winbar = {
		lualine_b = {
			{
				"filename",
				newfile_status = true,
				path = 1,
			},
		},
	},
})
