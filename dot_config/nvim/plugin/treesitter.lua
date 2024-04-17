---Configure treesitter plugin: https://github.com/nvim-treesitter/nvim-treesitter
-- Nvim Treesitter configurations and abstraction layer
-----------------------------------------------------------------------
if vim.g.__treesitter_plugin__ then
	return
end
vim.g.__treesitter_plugin__ = true

-- Register a Bootstrap hook
vim.api.nvim_create_autocmd("User", {
	pattern = "Bootstrap",
	callback = function()
		-- List of syntax files that are needed
		vim.cmd([[TSInstallSync! lua c query vim vimdoc]])
		vim.cmd([[TSUpdateSync]])
	end,
})

require("nvim-treesitter.configs").setup({
	auto_install = false,
	-- list of languages https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
	ensure_installed = {},
	ignore_install = {},
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

-- Nvim-Treesitter has an auto installer setup, but it can try to install a parser several
-- times if a file is loaded more than once quickly, and this happens when loading LSP configurations.
-- To avoid that issue I'm using my own auto installer that does the same, but it is only triggered
-- once per file type
local parsers = require("nvim-treesitter.parsers")
local group = vim.api.nvim_create_augroup("CustomTreesitterAutoInstaller", { clear = true })
local done = {}
vim.api.nvim_create_autocmd("FileType", {
	group = group,
	pattern = { "*" },
	callback = vim.schedule_wrap(function(ev)
		-- NOTE: For the FileType event, the field "match" has the filetype value
		local lang = parsers.ft_to_lang(ev.match)

		if done[lang] then
			return
		end
		done[lang] = true

		if parsers.list[lang] and not parsers.has_parser(lang) then
			vim.cmd(([[TSInstall! %s]]):format(lang))
		end
	end),
})
