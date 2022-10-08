return function()
	local luasnip = require("luasnip")
	require("luasnip.loaders.from_vscode").lazy_load()

	local function check_back_space()
		local col = vim.fn.col(".") - 1
		if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
			return true
		else
			return false
		end
	end

	-- Expand luasnip on tab
	local function tab_complete()
		if luasnip.expand_or_jumpable() then
			return "<Plug>luasnip-expand-or-jump"
		elseif check_back_space() then
			return "<Tab>"
		end

		return ""
	end

	local function s_tab_complete()
		if luasnip.jumpable(-1) then
			return "<Plug>luasnip-jump-prev"
		end

		return "<S-Tab>"
	end

	vim.keymap.set("i", "<Tab>", tab_complete, { expr = true })
	vim.keymap.set("s", "<Tab>", tab_complete, { expr = true })
	vim.keymap.set("i", "<S-Tab>", s_tab_complete, { expr = true })
	vim.keymap.set("s", "<S-Tab>", s_tab_complete, { expr = true })
	vim.keymap.set("i", "<C-E>", "<Plug>luasnip-next-choice", {})
	vim.keymap.set("s", "<C-E>", "<Plug>luasnip-next-choice", {})
end
