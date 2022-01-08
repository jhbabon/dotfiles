return function()
  -- TODO: Check https://github.com/williamboman/nvim-lsp-installer/wiki/Rust
  local lsp_installer = require('nvim-lsp-installer')

  -- TODO: Add keymappings
  lsp_installer.on_server_ready(function(server)
    server:setup({})
  end)
end
