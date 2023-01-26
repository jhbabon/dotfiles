if vim.g.mylsp_denols_loaded then
	return
end
vim.g.mylsp_denols_loaded = true

local binaries = require("binaries")
local append = binaries.lookups.append

require("conf-lsp.server").setup({
	name = "denols",
	pattern = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	bin = {
		spec = { name = "deno" },
		lookups = {
			append(binaries.lookups.system, { "lsp" }),
		},
	},
})
