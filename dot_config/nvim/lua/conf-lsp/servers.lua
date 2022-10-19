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
	local settings = config.settings or {}
	local capabilities = config.capabilities or require("conf-lsp.capabilities")
	local on_attach = config.on_attach

	-- Binary lookups
	local bin_config = config.bin or {}
	local spec = bin_config.spec or { name = name }
	local lookups = bin_config.lookups
	local bin = binaries.prepare(spec, lookups)

	local group = vim.api.nvim_create_augroup(("lsp-%s"):format(name), { clear = true })
	vim.api.nvim_create_autocmd({ "FileType" }, {
		once = true, -- run only after the first filetype is loaded
		group = group,
		pattern = pattern,
		callback = function()
			bin:resolve(option.wrap_some(function(exec)
				local lspconfig = require("lspconfig")[name]
				lspconfig.setup({
					cmd = exec.cmd(),
					capabilities = capabilities,
					settings = settings,
					on_attach = on_attach,
				})

				-- Ensure it's triggered after loading the first file
				lspconfig.launch()
			end))
		end,
	})
end

return servers
