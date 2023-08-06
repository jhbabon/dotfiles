---Configure lua_ls and efm for lua files
-----------------------------------------------------------------------
if vim.g.__lsp_lua_plugin__ then
	return
end
vim.g.__lsp_lua_plugin__ = true

local path = vim.api.nvim_get_runtime_file("", true)
table.remove(path, 1) -- remove ~/.config/$nvim since it collides with chezmoi files
table.insert(path, "lua/?.lua")
table.insert(path, "lua/?/init.lua")

local lazy_lsp = require("lazy-lsp")

lazy_lsp.lua_ls.setup({ pattern = { "lua" } }, function(_)
	return {
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
end)

lazy_lsp.efm.setup({ pattern = { "lua" } }, function(exec)
	local stylua = string.format(
		"%s ${--indent-width:tabSize} ${--range-start:charStart} ${--range-end:charEnd} --color Never -",
		exec({ "stylua" })
	)
	-- TODO: Review selene
	local luacheck = string.format("%s --codes --no-color --quiet -", exec({ "luacheck" }))

	return {
		settings = {
			rootMarkers = { ".git/" },
			languages = {
				lua = {
					{
						formatCommand = stylua,
						formatCanRange = true,
						formatStdin = true,
						rootMarkers = { "stylua.toml", ".stylua.toml" },
					},
					{
						prefix = "luacheck",
						lintCommand = luacheck,
						lintIgnoreExitCode = true,
						lintStdin = true,
						lintFormats = { "%.%#:%l:%c: (%t%n) %m" },
						rootMarkers = { ".luacheckrc" },
					},
				},
			},
		},
	}
end)
