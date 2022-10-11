return function()
	local function statusline(theme)
		-- Dirbuf customizations
		local dirbuf = {
			sections = {
				lualine_a = {
					{
						"filetype",
						icons_enabled = false,
					},
				},
				lualine_c = {
					{
						"filename",
						newfile_status = true,
						path = 1,
					},
				},
				lualine_z = { "location" },
			},
			filetypes = { "dirbuf" },
		}

		require("lualine").setup({
			options = {
				theme = theme,
				disabled_filetypes = {
					winbar = {
						"Trouble",
						"dirbuf",
						"aerial",
						"fugitive",
						"gitcommit",
					},
				},
			},
			extensions = { "aerial", "fugitive", dirbuf },
			sections = {
				lualine_a = { "branch" },
				lualine_b = { "diff", "diagnostics" },
				lualine_c = {
					{
						"filename",
						newfile_status = true,
						path = 1,
					},
				},
			},
			winbar = {
				lualine_a = { "mode" },
				lualine_c = { "aerial" },
			},
		})
	end

	-- keep track of the theme names
	local names = {}
	-- keep track of their indexes
	local indexes = {}
	-- keep track of the current index
	local current = 1
	-- use a different key name so the metatable
	-- proxy methods are called
	local function key(k)
		return ("_%s"):format(k)
	end

	local proxy = {
		__index = function(t, k)
			current = indexes[k]
			return rawget(t, key(k))
		end,

		__newindex = function(t, k, value)
			table.insert(names, k)
			for index, name in ipairs(names) do
				indexes[name] = index
			end

			rawset(t, key(k), value)
		end,
	}

	local themes = {}
	setmetatable(themes, proxy)

	function themes.everforest()
		vim.g.everforest_background = "hard"
		vim.g.everforest_enable_italic = true
		vim.g.everforest_better_performance = true

		vim.opt.background = "dark"
		vim.cmd([[colorscheme everforest]])

		statusline("everforest")
	end

	function themes.rosepine()
		require("rose-pine").setup({
			dark_variant = "moon",
		})

		vim.opt.background = "dark"
		vim.cmd([[colorscheme rose-pine]])

		statusline("rose-pine")
	end

	function themes.kanagawa()
		require("kanagawa").setup({})

		vim.opt.background = "dark"
		vim.cmd([[colorscheme kanagawa]])

		statusline("kanagawa")
	end

	function themes.github()
		vim.opt.background = "light"
		require("github-theme").setup({
			theme_style = "light",
		})

		statusline("github_light")
	end

	function themes.github_dark()
		vim.opt.background = "dark"
		require("github-theme").setup({
			theme_style = "dark",
		})

		statusline("github_dark")
	end

	-- Cycle through the themes, from current to next
	local function next_theme()
		local len = table.maxn(names)
		local nxt = current + 1
		if nxt > len then
			nxt = 1
		end
		local name = names[nxt]

		themes[name]()
	end

	-- NOTE: I'm using the term "palette" because I have already mappings starting with t (theme) or c (colors)
	require("keychain").set("n", [[<leader>pn]], next_theme, { hint = { "palette", "set next color palette" } })

	-- Setup theme
	themes.github()
end
