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
local treesitter_config = require("nvim-treesitter.config")
local installer_group = vim.api.nvim_create_augroup("CustomTreesitterAutoInstaller", { clear = true })
local enabler_group = vim.api.nvim_create_augroup("CustomTreesitterAutoEnabler", { clear = true })

local missing = treesitter_config.norm_languages("all", { installed = true, unsupported = true })
local installed = treesitter_config.norm_languages("all", { missing = true, unsupported = true })

for _, lang in ipairs(missing) do
	local filetypes = vim.treesitter.language.get_filetypes(lang)
	vim.api.nvim_create_autocmd("FileType", {
		group = installer_group,
		pattern = filetypes,
		once = true,
		callback = vim.schedule_wrap(function(ev)
			local language = vim.treesitter.language.get_lang(ev.match)
			require("nvim-treesitter").install({ language }):await(function()
				vim.api.nvim_create_autocmd("FileType", {
					group = enabler_group,
					pattern = filetypes,
					callback = vim.schedule_wrap(function()
						enable_treesitter()
					end),
				})

				enable_treesitter()
			end)
		end),
	})
end

for _, lang in ipairs(installed) do
	local filetypes = vim.treesitter.language.get_filetypes(lang)
	vim.api.nvim_create_autocmd("FileType", {
		group = enabler_group,
		pattern = filetypes,
		callback = vim.schedule_wrap(function()
			enable_treesitter()
		end),
	})
end

local defer = require("defer")
defer.very_lazy(function()
	-- Use tree-sitter to find pairs: https://github.com/yorickpeterse/nvim-tree-pairs
	vim.cmd([[packadd nvim-tree-pairs]])
	require("tree-pairs").setup()
end)
