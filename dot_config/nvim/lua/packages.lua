-- Packages
-- -----------------------------------------------------------------------
vim.cmd([[packadd packer.nvim]])

local function pkgs(use)
	-- Packer can manage itself
	use({ "wbthomason/packer.nvim", opt = true })

	-- Improve startup time for Neovim
	use({ "lewis6991/impatient.nvim" })

	use({ "kyazdani42/nvim-web-devicons" })

	use({ "nvim-lua/plenary.nvim" })

	-- NOTE: some parsers need node installed
	use({
		"nvim-treesitter/nvim-treesitter",
		requires = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"andymass/vim-matchup",
		},
		run = ":TSUpdate",
		setup = function()
			vim.g.loaded_matchit = 1
		end,
		config = require("conf-treesitter"),
	})

	-- File syntax extensions
	use({
		"NoahTheDuke/vim-just", -- regular syntax plugin since the treesitter module doesn't work very well
		opt = false,
	})

	-- Projects
	use({ "tpope/vim-projectionist", setup = require("conf-projectionist") })
	use({ "wfxr/minimap.vim", opt = true, setup = require("conf-minimap") })
	use({ "stevearc/aerial.nvim", config = require("conf-aerial") })

	-- File Tree
	use({
		"elihunter173/dirbuf.nvim",
		opt = true,
		setup = require("conf-explorer"),
	})

	-- Editing
	use({ "tpope/vim-eunuch" })      -- Vim sugar for the UNIX shell commands that need it the most (ex: :Delete)
	use({ "tpope/vim-vinegar" })     -- Enhance netrw project tree
	use({ "tpope/vim-characterize" }) -- Show Unicode character metadata pressing `ga`
	use({ "tpope/vim-abolish" })     -- Work with several variants of a word at once
	use({
		"AckslD/nvim-trevJ.lua",
		requires = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("lazy").load(function()
				require("trevj").setup()
				require("keychain").set("n", "<leader>ej", function()
					require("trevj").format_at_cursor()
				end, { hint = { "edit", "reverse J" } })
			end)
		end,
	})

	-- Registers
	use({
		-- NOTE: neoclip keeps it's own history of yanks, it doesn' use :registers
		"AckslD/nvim-neoclip.lua",
		config = function()
			require("lazy").load(function()
				require("neoclip").setup({
					enable_persistent_history = false,
					enable_macro_history = false,
				})
			end)
		end,
	})

	-- Undo tree
	use({
		"jiaoshijie/undotree",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		opt = true,
		setup = require("conf-undo"),
	})

	-- Snippets
	use({
		"L3MON4D3/LuaSnip",
		requires = {
			"rafamadriz/friendly-snippets",
		},
		config = require("conf-snippets"),
	})

	-- LSP
	use({
		"neovim/nvim-lspconfig",
		requires = {
			"jose-elias-alvarez/null-ls.nvim",
			"onsails/lspkind-nvim",
			"folke/trouble.nvim", -- for mappings
			"williamboman/mason.nvim",
			-- "williamboman/mason-lspconfig.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = require("conf-lsp"),
	})

	-- Show LSP progress information
	use({
		"j-hui/fidget.nvim",
		config = function()
			require("lazy").load(function()
				require("fidget").setup({
					text = {
						spinner = "dots",
					},
				})
			end)
		end,
	})

	-- Notifications
	use({
		"rcarriga/nvim-notify",
		config = require("conf-notify"),
	})

	-- Diagnostics
	use({
		"folke/trouble.nvim",
		requires = {
			{ "kyazdani42/nvim-web-devicons" },
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
		setup = require("conf-grepper"),
	})
	use({
		"pechorin/any-jump.vim",
		opt = true,
		setup = require("conf-any-jump"),
	})

	-- Mini plugin
	use({
		"echasnovski/mini.nvim",
		config = function()
			require("conf-mini")()
			-- Autocompletion
			require("conf-completion")()
		end,
	})

	-- Colorschemes and statusline
	use({
		"nvim-lualine/lualine.nvim",
		requires = {
			{ "kyazdani42/nvim-web-devicons" },
			"sainnhe/everforest",
			"rebelot/kanagawa.nvim",
			{
				"rose-pine/neovim",
				as = "rose-pine",
				tag = "v1.*",
			},
			-- FIXME: "projekt0n/github-nvim-theme",
		},
		config = require("conf-theme"),
	})

	-- Dim inactive portions of the code you're editing
	use({
		"folke/twilight.nvim",
		opt = true,
		setup = function()
			require("lazy").load(function()
				local setup = require("fp").once(function()
					vim.cmd.packadd("twilight.nvim")

					require("twilight").setup({
						context = 15,
					})
				end)

				local function toggle()
					setup()

					require("twilight").toggle()
				end

				local keychain = require("keychain")
				keychain.set("n", "<leader>uf", toggle, { hint = { "misc", "focus with Twilight" } })
			end)
		end,
	})

	-- Terminal manipulation
	use({
		"numToStr/FTerm.nvim",
		opt = true,
		setup = require("conf-terminal"),
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
		-- 	enable = true,
		-- 	threshold = 1, -- the amount in ms that a plugins load time must be over for it to be included in the profile
		-- },
	},
})
