return function()
  -- TODO: Check https://github.com/williamboman/nvim-lsp-installer/wiki/Rust
  local lsp_installer = require('nvim-lsp-installer')

  -- Automatically install default LSP servers
  -- Include the servers you want to have installed by default below
  local servers = {
    "rust_analyzer",
    "gopls",
    "yamlls",
    "tsserver",
    "sumneko_lua",
    "solargraph",
  }

  for _, name in pairs(servers) do
    local server_is_found, server = lsp_installer.get_server(name)
    if server_is_found then
      if not server:is_installed() then
        server:install()
      end
    end
  end

  -- TODO: Add keymappings
  lsp_installer.on_server_ready(function(server)
    server:setup({})
  end)
end
