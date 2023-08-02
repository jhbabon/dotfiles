-- Nvim Treesitter configuration

if vim.g.__treesitter_plugin__ then
	return
end
vim.g.__treesitter_plugin__ = true

-- Register a Bootstrap hook
vim.api.nvim_create_autocmd("User", {
	pattern = "Bootstrap",
	callback = function()
		local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
		ts_update()
	end,
})

require("nvim-treesitter.configs").setup({
	auto_install = true, -- only install languages on demand
	-- list of languages https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
	ensure_installed = {},
	sync_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
		enable = true,
	},
	indent = {
		enable = true,
	},
})
