---Setup LSP servers only when a buffer of the specified filetype is loaded
-- This module also uses the 'execs' module to find and optionally install executables
-- for LSP servers and other tools on demand

---@usage
--	require("lazy-lsp").lua_ls.setup({ pattern = { "lua" } }, function(exec)
--		return {
--			cmd = exec("lua-language-server").cmd, -- this is option, it will be done by lazy-setup if not present
--			settings = {}
--		}
--	end)

local async = require("plenary.async")
local execs = require("execs")
local scopes = require("execs.scopes")

---@module 'lazy_lsp'
local lazy_lsp = {}

local executables = {
	lua_ls = { "lua-language-server" },
	efm = { "efm-langserver", scopes = { scopes.system, scopes.mason.pkg({ name = "efm" }) } },
}
setmetatable(executables, {
	__index = function(_, key)
		return key
	end,
})

local group = vim.api.nvim_create_augroup("LazyLSP", { clear = true })

---Execute a callback in a FileType event, but only once
local function on_filetype(options, callback)
	local pattern = options.pattern
	assert(pattern, "the option `pattern` must be present and match a list of filetypes")

	vim.api.nvim_create_autocmd("FileType", {
		once = true,
		group = group,
		pattern = pattern,
		callback = vim.schedule_wrap(callback),
	})
end

---Get the executable from the system and other scopes
local function exec(spec)
	local async_resolve = async.wrap(execs.resolve, 2)
	local opt = async_resolve(spec)
	if opt:is_some() then
		local res = opt:unwrap()
		return res
	else
		if type(spec) == "string" then
			spec = { spec }
		end
		error(("executable %s not found"):format(spec[1]))
	end
end

-- TODO: Add Result type?
local function resolve_config(name, fn)
	local ok, result = pcall(fn, exec)
	if not ok then
		vim.notify(
			("Error seting up the LSP server '%s': %s"):format(name, result),
			vim.log.levels.ERROR,
			{ title = "LSP config" }
		)
	end

	return ok, result
end

local function setup(name, fn)
	vim.schedule(function()
		async.run(function()
			local ok, result = resolve_config(name, fn)
			if not ok then
				return
			end

			if result.cmd == nil then
				local status, res = resolve_config(name, function(ex)
					return {
						cmd = ex(executables[name]).cmd,
					}
				end)

				if not status then
					return
				end

				result = vim.tbl_deep_extend("force", result, res)
			end

			require("lspconfig")[name].setup(result)

			-- This wil retrigger FileType events, which in turn will
			-- trigger the events defined by lspconfig. These events
			-- will ensure that the LSP server is initialized and attached
			-- to the current buffer
			vim.cmd([[filetype detect]])
		end)
	end)
end

local function builder(name)
	local function default(options, fn)
		on_filetype(options, function()
			setup(name, fn)
		end)
	end

	return { setup = default }
end

-- Efm filetypes must be defined on first setup because it is used by lspconfig to
-- setup FileType events that attach buffers to the client, or to launch it the first time.
local efm_filetypes = { "lua", "go" }
local efm_init_options = {
	documentFormatting = true,
}
local efm = {}

-- Efm setup is special. Efm works with multiple filetypes, which means it can be called
-- from different filetype definitions.
-- The idea is as follows:
-- - The first time is called, it will setup the efm langserver normally
-- - If it is called more than once, it will update the existing server with
--   a 'workspace/didChangeConfiguration' message, adding new language and tools configurations
function efm.setup(options, fn)
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

	on_filetype(options, function()
		local clients = vim.lsp.get_active_clients({ name = "efm" })
		if #clients == 0 then
			local configurator = function(ex)
				local config = fn(ex)
				local defaults = { filetypes = efm_filetypes, init_options = efm_init_options }

				config = vim.tbl_extend("force", config, defaults)

				return config
			end

			return setup("efm", configurator)
		else
			vim.schedule(function()
				async.run(function()
					local ok, config = resolve_config("efm", fn)
					if not ok then
						return
					end

					if config.settings then
						for _, client in ipairs(clients) do
							client.notify("workspace/didChangeConfiguration", { settings = config.settings })
						end
					end
				end)
			end)
		end
	end)
end

lazy_lsp.efm = efm

setmetatable(lazy_lsp, {
	__index = function(_, key)
		return builder(key)
	end,
})

return lazy_lsp
