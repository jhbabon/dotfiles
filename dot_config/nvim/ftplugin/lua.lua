if vim.g.__lua_ftplugin__ then
	return
end
vim.g.__lua_ftplugin__ = true

local stylua = "stylua ${--indent-width:tabSize} ${--range-start:charStart} ${--range-end:charEnd} --color Never -"
local luacheck = "luacheck --codes --no-color --quiet -"
vim.lsp.config("efm", {
	filetypes = { "lua" },
	settings = {
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
})

local lua_lsp = vim.api.nvim_create_augroup("lua-lsp", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
	group = lua_lsp,
	callback = function(args)
		local format = function()
			vim.lsp.buf.format({
				filter = function(client)
					return client.name == "efm"
				end,
			})
		end

		vim.keymap.set("n", "<leader>lf", format, { buffer = args.buf, desc = "LSP: format file" })
		vim.keymap.set("n", "<leader>fm", format, { desc = "format current file" })
	end,
})

require("lsp").enable({ "luals", "efm" })
