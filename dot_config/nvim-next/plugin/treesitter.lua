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
	-- TODO: Add descriptions to mappings
	textobjects = {
		enable = true,
		swap = {
			enable = true,
			swap_next = {
				["<localleader>L"] = "@parameter.inner",
				["<localleader>J"] = "@function.outer",
				["<localleader>I"] = "@block.outer",
			},
			swap_previous = {
				["<localleader>H"] = "@parameter.inner",
				["<localleader>K"] = "@function.outer",
				["<localleader>U"] = "@block.outer",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["<localleader>l"] = "@parameter.inner",
				["]f"] = "@function.outer",
				["]b"] = "@block.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["<localleader><localleader>l"] = "@parameter.inner",
				["]F"] = "@function.outer",
				["]B"] = "@block.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["<localleader>h"] = "@parameter.inner",
				["[f"] = "@function.outer",
				["[b"] = "@block.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["<localleader><localleader>h"] = "@parameter.inner",
				["[F"] = "@function.outer",
				["[B"] = "@block.outer",
				["[]"] = "@class.outer",
			},
		},
	},
})

-- Use treesitter's folding module
vim.opt.foldlevel = 5
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
