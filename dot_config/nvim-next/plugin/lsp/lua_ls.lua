if vim.g.__lsp_lua_ls_plugin__ then
	return
end
vim.g.__lsp_lua_ls_plugin__ = true

local path = vim.api.nvim_get_runtime_file("", true)
table.insert(path, "lua/?.lua")
table.insert(path, "lua/?/init.lua")

require("lazy-lsp").lua_ls.setup({
	lazy = {
		pattern = { "lua" },
	},
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				path = path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim", "_G" },
			},
			workspace = {
        -- Make the server aware of Neovim runtime files
        library = path,
      },
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})
