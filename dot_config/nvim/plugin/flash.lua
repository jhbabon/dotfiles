---Configure flash.nvim plugin: https://github.com/folke/flash.nvim
-- Navigate your code with search labels, enhanced character motions
-- and Treesitter integration
-----------------------------------------------------------------------
if vim.g.__flash_plugin__ then
	return
end
vim.g.__flash_plugin__ = true

require("defer").offload(function()
	require("flash").setup({
		modes = {
			search = {
				enabled = false,
			}
		}
	})

	local function jump()
		require("flash").jump()
	end

	local function treesitter()
		require("flash").treesitter()
	end

	local function remote()
		require("flash").remote()
	end

	local function treesitter_search()
		require("flash").treesitter_search()
	end

	local function toggle()
		require("flash").toggle()
	end

	vim.keymap.set({ "n", "x", "o" }, "<leader>hh", jump, { desc = _G.desc({ "flash", "jump" }) })
	vim.keymap.set({ "n", "x", "o" }, "<leader>ht", treesitter, { desc = _G.desc({ "flash", "treesitter" }) })
	vim.keymap.set({ "o" }, "r", remote, { desc = _G.desc({ "flash", "remote" }) })
	vim.keymap.set({ "o", "x" }, "R", treesitter_search, { desc = _G.desc({ "flash", "treesitter search" }) })
	vim.keymap.set({ "c" }, "<c-s>", toggle, { desc = _G.desc({ "flash", "toggle search" }) })
end)
