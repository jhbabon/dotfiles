local lsp = {}
local cache = {}

-- Install the given server, if is not installed already
function lsp.install(name)
  if cache[name] then
    return
  end

  local lsp_installer = require("nvim-lsp-installer")
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found then
    if not server:is_installed() then
      server:install()
    end
  end

  cache[name] = true
end

return lsp
