local lsp = {}

-- Install the given server if it doesn't exist
function lsp.install(name)
  local lsp_installer = require('nvim-lsp-installer')

  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found then
    if not server:is_installed() then
      server:install()
    end
  end
end

return lsp
