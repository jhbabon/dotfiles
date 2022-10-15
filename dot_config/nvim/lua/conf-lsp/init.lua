-- Servers are configured via plugin/lsp/{servername}.lua
-- These files are automatically loaded by neovim and they are
-- executed after this configuration
return function()
	-- ---------------------------------------------------
	-- Mason setup
	-- This has to run before anything else
	-- ---------------------------------------------------
	require("mason").setup({
		PATH = "skip",
		ui = { border = "rounded" },
	})

	require("lazy").load(function()
		-- ---------------------------------------------------
		-- UI
		-- ---------------------------------------------------
		-- @see https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#change-diagnostic-symbols-in-the-sign-column-gutter
		-- icons taken from lualine
		local icons = {
			Error = " ", -- xf659
			Warn = " ", -- xf529
			Info = " ", -- xf7fc
			Hint = " ", -- xf835
		}
		for type, icon in pairs(icons) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end
		require("lspkind").init({})

		-- ---------------------------------------------------
		-- General callbacks for attached/detached servers
		-- ---------------------------------------------------
		require("conf-lsp.mappings")()
		require("conf-lsp.format")()
		require("conf-lsp.null-ls")()
	end)
end
