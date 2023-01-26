local option = require("option")
local binaries = require("binaries")

local function none(_)
	return {}
end

local server = {}

-- Setup a server and only initialize it when files of the given pattern are loaded
-- If the server is loaded for the first time, it will try to find the binary that excutes it
-- @see binaries
function server.setup(config)
	-- Mandatory fields
	local name = config.name
	assert(name, "server name is missing")
	local pattern = config.pattern
	assert(pattern, "server file pattern is missing")

	-- Binary lookups
	local bin_config = config.bin or {}
	local spec = bin_config.spec or { name = name }
	local lookups = bin_config.lookups
	local bin = binaries.prepare(spec, lookups)

	-- Custom setup options generator
	local setup_hook = config.hook or none

	local group = vim.api.nvim_create_augroup(("lsp-%s"):format(name), { clear = true })
	vim.api.nvim_create_autocmd({ "FileType" }, {
		once = true, -- run only after the first filetype is loaded
		group = group,
		pattern = pattern,
		callback = function()
			bin:resolve(option.wrap_some(function(exec)
				local lspconfig = require("lspconfig")
				local util = lspconfig.util

				local defaults = {
					cmd = exec.cmd(),
					capabilities = require("conf-lsp.capabilities"),
				}
				local setup = vim.tbl_extend("force", defaults, setup_hook(util))
				local lspserver = lspconfig[name]
				lspserver.setup(setup)

				-- Ensure it's triggered after loading the first file
				lspserver.launch()
			end))
		end,
	})
end

return server
