return function()
  local utils = require("utils")
  local lsp = require("lsp")

  -- @see https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#change-diagnostic-symbols-in-the-sign-column-gutter
  -- icons taken from lualine
  local icons = {
    Error = " ", -- xf659
    Warn = " ", -- xf529
    Info = " ", -- xf7fc
    Hint = " ", -- xf835
  }
  for type, icon in pairs(icons) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  -- TODO: Check https://github.com/williamboman/nvim-lsp-installer/wiki/Rust
  local lsp_installer = require("nvim-lsp-installer")

  local runtime_path = vim.split(package.path, ";")
  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")

  local servers = {
    rust_analyzer = { filetypes = { "rust" } },
    gopls = { filetypes = { "go" } },
    yamlls = { filetypes = { "yaml" } },
    tsserver = { filetypes = { "typescript", "javascript" } },
    solargraph = { filetypes = { "ruby" } },
    sumneko_lua = {
      filetypes = { "lua" },
      setup = {
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = "LuaJIT",
              -- Setup your lua path
              path = runtime_path,
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { "vim" },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
              enable = false,
            },
          },
        },
      },
    },
  }

  -- Automatically install default LSP servers on filetype load
  -- TODO: Review, maybe is better to install servers only once
  --   instead of doing it per filetype
  for name, config in pairs(servers) do
    for _, ft in pairs(config.filetypes) do
      utils.augroups({
        ["auto_install_lsp_" .. name] = {
          { "FileType", ft, "lua require('lsp').install('" .. name .. "')" },
        },
      })
    end
  end

  local defaults = {
    on_attach = lsp.on_attach,
  }

  -- TODO: Add keymappings
  lsp_installer.on_server_ready(function(server)
    local setup = defaults
    local custom = servers[server.name]

    if custom and custom.setup then
      setup = vim.tbl_extend("force", setup, custom.setup)
    end

    server:setup(setup)
  end)
end
