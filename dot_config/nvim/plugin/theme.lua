---Configure statusline and colorscheme
-- Statusline is set with lualine: https://github.com/nvim-lualine/lualine.nvim
--   A blazing fast and easy to configure neovim statusline plugin written in pure lua
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

vim.api.nvim_create_autocmd("Colorscheme", {
	pattern = { "alabaster" },
	callback = vim.schedule_wrap(function()
		-- Alabaster modifications
		vim.cmd([[highlight Comment cterm=italic gui=italic]])
		vim.cmd([[highlight Keyword cterm=italic gui=italic]])
		vim.cmd([[highlight @keyword cterm=italic gui=italic]])
		vim.cmd([[highlight htmlItalic cterm=italic gui=italic]])
		vim.cmd([[highlight mkdCode cterm=italic gui=italic]])
		vim.cmd([[highlight @text.emphasis cterm=italic gui=italic]])
		vim.cmd([[highlight @parameter cterm=italic gui=italic]])
	end),
})

vim.opt.background = "light"
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

---Display attached LSP client names
local function lsp()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients({ bufnr = bufnr })
	if #clients == 0 then
		return ""
	end

	local names = {}
	for _, client in ipairs(clients) do
		table.insert(names, client.name)
	end

	return table.concat(names, [[ · ]])
end

require("lualine").setup({
	options = {
		theme = "auto",
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
	extensions = { "toggleterm", "trouble", "fugitive", dirbuf },
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff" },
		lualine_c = { "diagnostics" },
		lualine_x = {
			lsp,
			"encoding",
			"fileformat",
			"filetype",
		},
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
