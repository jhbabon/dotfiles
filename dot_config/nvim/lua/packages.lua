-- Packages
-- -----------------------------------------------------------------------
vim.cmd([[packadd packer.nvim]])

local function pkgs(use)
	-- Packer can manage itself
	use({ "wbthomason/packer.nvim", opt = true })

	-- Improve startup time for Neovim
	use({ "lewis6991/impatient.nvim" })

	use({ "kyazdani42/nvim-web-devicons" })

	-- NOTE: some parsers need node installed
	use({
		"nvim-treesitter/nvim-treesitter",
		requires = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"andymass/vim-matchup",
			"nvim-treesitter/nvim-treesitter-context",
		},
		run = ":TSUpdate",
		setup = function()
			vim.g.loaded_matchit = 1
		end,
		config = require("conf-treesitter"),
	})

	-- Projects
	use({ "tpope/vim-sleuth" })
	use({
		"klen/nvim-config-local",
		config = function()
			require("config-local").setup({ commands_create = false })
		end,
	})
	use({ "tpope/vim-projectionist", setup = require("setup-projectionist") })
	use({ "wfxr/minimap.vim", setup = require("conf-minimap") })
	-- use({ "sidebar-nvim/sidebar.nvim", config = require("conf-sidebar") })
	use({ "stevearc/aerial.nvim", config = require("conf-aerial") })

	-- File Tree
	use({
		"elihunter173/dirbuf.nvim",
		config = require("conf-explorer"),
	})

	-- Editing
	use({ "tpope/vim-eunuch" })
	use({ "tpope/vim-vinegar" })
	use({ "tpope/vim-characterize" })
	use({
		"AckslD/nvim-trevJ.lua",
		requires = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("trevj").setup()
			require("keychain").set("n", "<leader>ej", function()
				require("trevj").format_at_cursor()
			end, { hint = { "edit", "reverse J" } })
		end,
	})

	-- Registers
	use({
		-- NOTE: neoclip keeps it's own history of yanks, it doesn' use :registers
		"AckslD/nvim-neoclip.lua",
		config = function()
			require("neoclip").setup({
				enable_persistent_history = false,
				enable_macro_history = false,
			})
		end,
	})

	-- Snippets
	use({
		"L3MON4D3/LuaSnip",
		requires = {
			"rafamadriz/friendly-snippets",
		},
		config = require("conf-snippets"),
	})

	-- Autocompletion
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
		},
		config = require("conf-completion"),
	})

	-- LSP
	use({
		"neovim/nvim-lspconfig",
		requires = {
			"onsails/lspkind-nvim",
			"folke/trouble.nvim", -- for mappings
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"nvim-lua/plenary.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
		config = require("conf-lsp"),
	})

	-- Show LSP progress information
	use({
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup({})
		end,
	})

	-- Diagnostics
	use({
		"folke/trouble.nvim",
		requires = {
			"kyazdani42/nvim-web-devicons",
		},
		config = require("conf-trouble"),
	})

	-- Git
	use({
		"lewis6991/gitsigns.nvim",
		requires = {
			"tpope/vim-fugitive",
			"nvim-lua/plenary.nvim",
		},
		config = require("conf-git"),
	})

	-- Search
	use({
		"mhinz/vim-grepper",
		requires = {
			"folke/trouble.nvim",
		},
		setup = require("setup-grepper"),
	})
	use({ "pechorin/any-jump.vim", setup = require("setup-any-jump") })

	-- Mini plugins AND colorschemes & statusline
	-- They are configures together because the statusline
	-- is set up with Mini
	use({
		"echasnovski/mini.nvim",
		requires = {
			"sainnhe/everforest",
			"rebelot/kanagawa.nvim",
			{ "rose-pine/neovim", as = "rose-pine", tag = "v1.*" },
		},
		config = function()
			local confs = {
				require("conf-theme"),
				require("conf-mini"),
			}

			for _, fn in pairs(confs) do
				fn()
			end
		end,
	})

	-- Dim inactive portions of the code you're editing
	use({
		"folke/twilight.nvim",
		config = function()
			require("twilight").setup({
				context = 15,
			})

			local keychain = require("keychain")
			keychain.set("n", "<leader>uf", [[:Twilight<cr>]], { hint = { "misc", "focus with Twilight" } })
		end,
	})

	-- Terminal manipulation
	use({
		"numToStr/FTerm.nvim",
		config = function()
			require("FTerm").setup({})

			local keychain = require("keychain")
			keychain.set("n", "<F1>", function()
				return require("FTerm").toggle()
			end, { hint = { "terminal", "toggle terminal" } })
			keychain.set("t", "<F1>", function()
				return require("FTerm").toggle()
			end)
		end,
	})

	-- Copy from beyond (SSH)
	use({
		"ojroques/vim-oscyank",
		config = function()
			local hint = { "yank", "Yank/Copy from anywhere using the ANSI OS52 sequence" }
			local keychain = require("keychain")
			keychain.set("n", "<leader>o", [[<Plug>OSCYank]], { noremap = false, silent = false, hint = hint })
			keychain.set("v", "<leader>o", [[:OSCYank<CR>]], { hint = hint })
		end,
	})
end

return require("packer").startup({
	pkgs,
	config = {
		disable_commands = true,
		-- Move to lua dir so impatient.nvim can cache it
		compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
		-- Remove comments to enable profiling
		-- profile = {
		--   enable = true,
		--   threshold = 1, -- the amount in ms that a plugins load time must be over for it to be included in the profile
		-- },
	},
})
