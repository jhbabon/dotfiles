local fp = require("fp")
local option = require("option")
local binaries = require("binaries")

local servers = {}

-- Setup a server and only initialize it when files of the given pattern are loaded
-- If the server is loaded for the first time, it will try to find the binary that excutes it
-- @see binaries
function servers.setup(config)
	-- Mandatory fields
	local name = config.name
	local pattern = config.pattern

	-- Optional
	local root_pattern = config.root_pattern or { ".git" }
	local settings = config.settings or {}
	local capabilities = config.capabilities or require("conf-lsp.capabilities")
	local on_attach = config.on_attach

	local root_dir = fp.once(function()
		local path = vim.fs.find(root_pattern, { upward = true })
		return vim.fs.dirname(path[1])
	end)

	-- Binary lookups
	local bin_config = config.bin or {}
	local spec = bin_config.spec or { name = name }
	local lookups = bin_config.lookups
	local bin = binaries.prepare(spec, lookups)

	local group = vim.api.nvim_create_augroup(("lsp-%s"):format(name), { clear = true })
	vim.api.nvim_create_autocmd({ "FileType", "BufAdd" }, {
		group = group,
		pattern = pattern,
		callback = function()
			bin:resolve(option.wrap_some(function(exec)
				vim.lsp.start({
					name = name,
					cmd = exec.cmd(),
					root_dir = root_dir(),
					capabilities = capabilities,
					settings = settings,
					on_attach = on_attach,
				})
			end))
		end,
	})
end

return servers
