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
		require("nvim-treesitter").install({ "lua", "c", "query", "vim", "vimdoc" }):wait(30000)
		require("nvim-treesitter").update():wait(30000)
	end,
})

local function enable_treesitter()
	-- Highlight
	vim.treesitter.start()

	-- Folds
	vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
	vim.wo[0][0].foldmethod = "expr"
	vim.wo[0][0].foldlevel = 20

	-- Indentation
	vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end

-- Install tree-sitter parsers and enable them on demand
local group = vim.api.nvim_create_augroup("CustomTreesitterAutoInstaller", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = group,
	pattern = { "*" },
	callback = vim.schedule_wrap(function(ev)
		-- NOTE: For the FileType event, the field "match" has the filetype value
		local lang = vim.treesitter.language.get_lang(ev.match)

		local available = require("nvim-treesitter.config").get_available()
		if not vim.list_contains(available, lang) then
			return
		end

		local installed = require("nvim-treesitter.config").get_installed()
		if not vim.list_contains(installed, lang) then
			require("nvim-treesitter").install({ lang }):wait(30000)
		end

		enable_treesitter()
	end),
})

local defer = require("defer")
defer.very_lazy(function()
	-- Use tree-sitter to find pairs: https://github.com/yorickpeterse/nvim-tree-pairs
	vim.cmd([[packadd nvim-tree-pairs]])
	require("tree-pairs").setup()
end)
