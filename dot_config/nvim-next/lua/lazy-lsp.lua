-- Lazyly setup LSP servers only when matching filetypes are loaded
-- By default it will try to install the server using Mason if is not
-- present in the system or managed by Mason already.
--
-- It is used like `lspconfig`, but with a few extra config options:
-- - config.lazy.pattern: the list of filetypes to match, like `{ "lua" }`
-- - config.lazy.bin: a bin instance, @see binaries.prepare
--
-- @example:
--	require("lazy-lsp").lua_ls.setup({
--		lazy = {
--			pattern = { "lua" },
--			bin = binaries.prepare("lua-language-server", my_lookup),
--		}
--	})
local binaries = require("binaries")
local option = require("option")

local lazy_lsp = {}

-- More aliases can be found here:
-- https://github.com/williamboman/mason-lspconfig.nvim/blob/e86a4c84ff35240639643ffed56ee1c4d55f538e/lua/mason-lspconfig/mappings/server.lua
local aliases = {
	lua_ls = "lua-language-server",
}
setmetatable(aliases, {
	__index = function(_, key)
		return key
	end,
})

local group = vim.api.nvim_create_augroup("LazyLSP", { clear = true })

local function build(name)
	local function setup(config)
		local lazy = config.lazy or {}
		local pattern = lazy.pattern
		assert(pattern, "the option `lazy.pattern` must be present and match a list of filetypes")

		vim.api.nvim_create_autocmd("FileType", {
			once = true,
			group = group,
			pattern = pattern,
			callback = vim.schedule_wrap(function()
				local bin = lazy.bin or binaries.prepare(aliases[name])
				bin:resolve(option.wrap_some(function(exec)
					local cfg = vim.tbl_extend("force", config, { cmd = exec.cmd() })
					require("lspconfig")[name].setup(cfg)

					-- this will trigger the FileType event again, which
					-- in turn will ensure that the lsp server starts
					-- and the current file is attached to it
					vim.cmd([[filetype detect]])
				end))
			end),
		})
	end

	return { setup = setup }
end

setmetatable(lazy_lsp, {
	__index = function(_, key)
		return build(key)
	end,
})

return lazy_lsp
