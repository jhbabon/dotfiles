if vim.g.mylsp_tsserver_loaded then
	return
end
vim.g.mylsp_tsserver_loaded = true

local binaries = require("binaries")

local capabilities = vim.tbl_extend("force", require("conf-lsp.capabilities"), {
	-- disable formatting
	documentFormattingProvider = false,
	documentrangeFormattingProvider = false,
})

local function organize_imports(bufnr)
	local params = {
		command = "_typescript.organizeImports",
		arguments = { bufnr },
		title = "",
	}
	vim.lsp.buf.execute_command(params)
end

local on_attach = function(_, bufnr)
	vim.keymap.set("n", "<LocalLeader>O", function()
		organize_imports(bufnr)
	end, { buffer = bufnr })
end

local append = binaries.lookups.append

require("conf-lsp.server").setup({
	name = "tsserver",
	pattern = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	bin = {
		spec = { name = "typescript-language-server" },
		lookups = {
			append(binaries.lookups.node_module, { "--stdio" }),
			append(binaries.lookups.system, { "--stdio" }),
			append(binaries.lookups.if_exec("npm", binaries.lookups.mason), { "--stdio" }),
		},
	},
	hook = function(_)
		return {
			capabilities = capabilities,
			on_attach = on_attach,
			-- This prevents it to be loaded along with denols
			single_file_support = false,
		}
	end,
})
