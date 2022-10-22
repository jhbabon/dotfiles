return function()
	local function statusline(theme)
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
				theme = theme,
				globalstatus = true,
				disabled_filetypes = {
					winbar = {
						"Trouble",
						"dirbuf",
						"aerial",
						"fugitive",
						"gitcommit",
						"minimap",
					},
				},
			},
			extensions = { "aerial", "fugitive", dirbuf },
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
				lualine_c = { "aerial" },
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

	-- Define themes
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

	local function github(style)
		if style == "light" then
			vim.opt.background = "light"
		else
			vim.opt.background = "dark"
		end

		require("github-theme").setup({
			theme_style = style,
		})

		statusline(("github_%s"):format(style))
	end

	function themes.github_light()
		github("light")
	end

	function themes.github()
		github("light")
	end

	function themes.github_dimmed()
		github("dimmed")
	end

	function themes.github_dark()
		github("dark")
	end

	-- Setup theme
	local default = "github_dimmed"
	local name = vim.env.DOTFILES_NVIM_THEME or default
	local theme = themes[name] or themes[default]
	theme()
end
