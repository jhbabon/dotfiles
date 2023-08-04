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
	-- TODO: Does the order of arguments make sense?
	-- TODO: Better names for the whole binaries handling, it's a mess between bin, exec, spec, etc
	local function setup(fn, options)
		local pattern = options.pattern
		assert(pattern, "the option `pattern` must be present and match a list of filetypes")

		vim.api.nvim_create_autocmd("FileType", {
			once = true,
			group = group,
			pattern = pattern,
			callback = vim.schedule_wrap(function()
				local specs = options.bins or { [name] = aliases[name] }
				local bins = binaries.prepare_many(specs)
				bins:resolve(function(results)
					local placeholders = {}
					-- check the lsp server binary
					for key, option in pairs(results) do
						option:and_then(function(exec)
							placeholders[key] = exec
						end)
					end

					if placeholders[name] == nil then
						vim.notify(("LSP binary not found: %s"):format(name), vim.log.levels.ERROR, { title = "LSP config" })
						return
					end

					local config = fn(placeholders)
					require("lspconfig")[name].setup(config)

					-- this will trigger the FileType event again, which
					-- in turn will ensure that the lsp server starts
					-- and the current file is attached to it
					vim.cmd([[filetype detect]])
				end)
			end),
		})
	end

	return { setup = setup }
end

-- EFM filetypes must be defined on setup
local efm_filetypes = { "lua" }
local efm = {}
function efm.setup(fn, options)
	-- check if it exists
	local clients = vim.lsp.get_active_clients({ name = "efm" })
	if #clients == 0 then
		-- if not, normal setup
		local chain = function(bins)
			local config = fn(bins)
			config = vim.tbl_extend("force", config, { filetypes = efm_filetypes })

			return config
		end

		local bins = options.bins or {}
		if bins.efm == nil then
			bins.efm = { { name = "efm", mason = { link_name = "efm-langserver" } } }
		end
		options.bins = bins

		return build("efm").setup(chain, options)
	else
		-- if it does, just update it with 'workspace/didChangeConfiguration'
		local specs = options.bins or {}
		options.bins.efm = nil -- no need to look for it
		local bins = binaries.prepare_many(specs)
		bins:resolve(function(results)
			local placeholders = {}
			for key, option in pairs(results) do
				option:and_then(function(exec)
					placeholders[key] = exec
				end)

				local config = fn(placeholders)

				for _, client in ipairs(clients) do
					if config.settings then
						client.notify("workspace/didChangeConfiguration", { settings = config.settings })
					end
				end
			end
		end)
	end
end

local lazy_lsp = { efm = efm }

setmetatable(lazy_lsp, {
	__index = function(_, key)
		return build(key)
	end,
})

return lazy_lsp
