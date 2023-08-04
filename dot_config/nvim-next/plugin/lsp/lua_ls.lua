if vim.g.__lsp_lua_ls_plugin__ then
	return
end
vim.g.__lsp_lua_ls_plugin__ = true

local path = vim.api.nvim_get_runtime_file("", true)
table.insert(path, "lua/?.lua")
table.insert(path, "lua/?/init.lua")

local lazy_lsp = require("lazy-lsp")

lazy_lsp.lua_ls.setup(function(bins)
	return {
		cmd = bins.lua_ls.cmd(),
		init_options = {
			documentFormatting = false,
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
	}
end, { pattern = { "lua" } })

-- TODO: maybe move both configs to a lsp/lua.lua file?
lazy_lsp.efm.setup(function(bins)
	local command = string.format(
		"%s ${--indent-width:tabSize} ${--range-start:charStart} ${--range-end:charEnd} --color Never -",
		bins.stylua.cmd
	)
	return {
		cmd = bins.efm.cmd(),
		init_options = {
			documentFormatting = true,
		},
		settings = {
			rootMarkers = { ".git/" },
			languages = {
				lua = {
					{
						formatCommand = command,
						formatCanRange = true,
						formatStdin = true,
						rootMarkers = { "stylua.toml", ".stylua.toml" },
					},
				},
			},
		},
	}
end, { pattern = { "lua" }, bins = { stylua = "stylua" } })
