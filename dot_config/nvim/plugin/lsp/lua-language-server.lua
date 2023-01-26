if vim.g.mylsp_sumneko_lua_loaded then
	return
end
vim.g.mylsp_sumneko_lua_loaded = true

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local capabilities = vim.tbl_extend("force", require("conf-lsp.capabilities"), {
	-- disable formatting
	documentFormattingProvider = false,
	documentrangeFormattingProvider = false,
})

local settings = {
	Lua = {
		runtime = {
			-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
			version = "LuaJIT",
			-- Setup your lua path
			path = runtime_path,
		},
		diagnostics = {
			-- Get the language server to recognize the `vim` global
			globals = { "vim", "hs" },
		},
		workspace = {
			-- Make the server aware of Neovim runtime files
			library = vim.api.nvim_get_runtime_file("", true),
		},
		-- Do not send telemetry data containing a randomized but unique identifier
		telemetry = {
			enable = false,
		},
	},
}

require("conf-lsp.server").setup({
	name = "sumneko_lua",
	pattern = { "lua" },
	bin = {
		spec = { name = "lua-language-server" },
	},
	hook = function(_)
		return {
			capabilities = capabilities,
			settings = settings,
		}
	end,
})
