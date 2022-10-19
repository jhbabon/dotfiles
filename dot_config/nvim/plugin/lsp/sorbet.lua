if vim.g.mylsp_sorbet_loaded then
	return
end
vim.g.mylsp_sorbet_loaded = true

local binaries = require("binaries")

local srb = binaries.lookups.append(binaries.lookups.local_bin, { "tc", "--lsp" })

require("conf-lsp.servers").setup({
	name = "sorbet",
	pattern = { "ruby" },
	bin = {
		spec = { name = "srb" },
		lookups = { srb },
	},
})
