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

-- Delay everything on FileType event
local function delay(options, callback)
	local pattern = options.pattern
	assert(pattern, "the option `pattern` must be present and match a list of filetypes")

	vim.api.nvim_create_autocmd("FileType", {
		once = true,
		group = group,
		pattern = pattern,
		callback = vim.schedule_wrap(callback),
	})
end

local function default_setup(name, options, fn)
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
end

local function build(name)
	-- TODO: Does the order of arguments make sense?
	-- TODO: Better names for the whole binaries handling, it's a mess between bin, exec, spec, etc
	local function setup(fn, options)
		delay(options, function()
			default_setup(name, options, fn)
		end)
	end

	return { setup = setup }
end

-- Efm filetypes must be defined on first setup because it is used by lspconfig to
-- setup FileType events that attach buffers to the client, or to launch it the first time.
local efm_filetypes = { "lua" }
local efm = {}

-- Efm setup is special. Efm works with multiple filetype, which means it can be called
-- from different filetype definitions.
-- The idea is as follows:
-- - The first time is called, it will setup the efm langserver normally
-- - If it is called more than once, it will update the existing server with
--   a 'workspace/didChangeConfiguration' message, adding new language and tools configurations
function efm.setup(fn, options)
	local pattern = options.pattern or {}
	local lookup = {}
	for _, ft in ipairs(efm_filetypes) do
		lookup[ft] = true
	end

	for _, ft in ipairs(pattern) do
		if not lookup[ft] then
			local msg = "The FileType pattern provided to lazy-lsp, '%s', is not in the lazy-lsp.efm_filetypes list."
			msg = msg .. "\nYou must add this filetype to this list first before using the 'efm' language server setup."

			vim.notify(msg:format(ft), vim.log.levels.ERROR, { title = "LSP config" })

			return
		end
	end

	delay(options, function()
		local clients = vim.lsp.get_active_clients({ name = "efm" })
		if #clients == 0 then
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

			return default_setup("efm", options, chain)
		else
			local specs = options.bins or {}
			options.bins.efm = nil -- no need to look for efm binary
			local bins = binaries.prepare_many(specs)
			bins:resolve(function(results)
				local placeholders = {}
				for key, option in pairs(results) do
					option:and_then(function(exec)
						placeholders[key] = exec
					end)
				end

				local config = fn(placeholders)

				for _, client in ipairs(clients) do
					if config.settings then
						client.notify("workspace/didChangeConfiguration", { settings = config.settings })
					end
				end
			end)
		end
	end)
end

local lazy_lsp = { efm = efm }

setmetatable(lazy_lsp, {
	__index = function(_, key)
		return build(key)
	end,
})

return lazy_lsp
