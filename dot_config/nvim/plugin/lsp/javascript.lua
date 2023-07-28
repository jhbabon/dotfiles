---Configure denols javascript and typescript files
-----------------------------------------------------------------------
if vim.g.__lsp_javascript_plugin__ then
	return
end
vim.g.__lsp_javascript_plugin__ = true

local lazy_lsp = require("lazy-lsp")
local scopes = require("execs.scopes")
local util = require("lspconfig").util

local pattern = {
	"javascript",
	"javascriptreact",
	"javascript.jsx",
	"typescript",
	"typescriptreact",
	"typescript.tsx",
}

local function args(scope, extra)
	return function(name)
		return scope(name):map(function(cmd)
			for _, arg in ipairs(extra) do
				table.insert(cmd, arg)
			end

			return cmd
		end)
	end
end

local deno_args = { "lsp" }
local deno_spec = { "deno", scopes = { args(scopes.system, deno_args), args(scopes.mason, deno_args) } }
lazy_lsp.denols.setup({ pattern = pattern }, function(exec)
	return {
		cmd = exec(deno_spec).cmd,
		root_dir = util.root_pattern("deno.json", "deno.jsonc"),
	}
end)
