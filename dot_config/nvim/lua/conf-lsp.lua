return function()
  -- ---------------------------------------------------
  -- lspconfig UI
  -- ---------------------------------------------------
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

  -- ---------------------------------------------------
  -- lsp-installer & lspconfig
  -- ---------------------------------------------------
  -- TODO: Check https://github.com/williamboman/nvim-lsp-installer/wiki/Rust
  local lsp_installer = require("nvim-lsp-installer")
  local utils = require("utils")
  local keychain = require("keychain")

  local function mappings(_, bufnr)
    -- Normal mappings
    local function map(...)
      keychain.nmap_buf(bufnr, ...)
    end
    map("]e", vim.diagnostic.goto_next, { hint = { "lsp", "next diagnostic" } })
    map("[e", vim.diagnostic.goto_prev, { hint = { "lsp", "previous diagnostic" } })
    map("<leader>li", vim.lsp.buf.implementation, { hint = { "lsp", "go to implementation" } })
    map("<leader>lh", vim.lsp.buf.hover, { hint = { "lsp", "hover" } })
    map("<leader>ls", vim.lsp.buf.signature_help, { hint = { "lsp", "signature" } })
    map("<leader>ln", vim.lsp.buf.rename, { hint = { "lsp", "rename" } })
    map("<leader>lg", vim.diagnostic.open_float, { hint = { "lsp", "line diagnostic" } })
    map("<leader>lc", vim.lsp.buf.code_action, { hint = { "lsp", "code action" } })
    map("<leader>lf", vim.lsp.buf.formatting_sync, { hint = { "lsp", "format file" } })
    map("<leader>la", vim.lsp.buf.formatting, { hint = { "lsp", "async format file" } })

    map("<leader>ly", vim.lsp.buf.document_symbol, { hint = { "lsp", "document symbols" } })

    -- Use Trouble for references and definitions
    map("<leader>lr", [[<cmd>Trouble lsp_references<cr>]], { hint = { "lsp", "references" } })
    map("<leader>lt", [[<cmd>Trouble lsp_type_definitions<cr>]], { hint = { "lsp", "go to type definition" } })
    map("<leader>ld", [[<cmd>Trouble lsp_definitions<cr>]], { hint = { "lsp", "go to definition" } })

    -- Visual mappings
    keychain.set("v", "<leader>lc", vim.lsp.buf.range_code_action, { hint = { "lsp", "code action" }, buffer = bufnr })
  end

  -- default on_attach function for every server
  local function on_attach(client, bufnr)
    if client.resolved_capabilities.document_formatting then
      vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]])
    end
    mappings(client, bufnr)
  end

  -- for lua LSP server
  local runtime_path = vim.split(package.path, ";")
  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")

  local servers = {
    rust_analyzer = {
      filetypes = { "rust" },
      setup = {
        settings = {
          -- to enable rust-analyzer settings visit:
          -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
          ["rust-analyzer"] = {
            -- enable clippy on save
            checkOnSave = {
              command = "clippy",
            },
          },
        },
      },
    },

    gopls = {
      filetypes = { "go" },
      setup = {
        on_attach = function(client, bufnr)
          client.resolved_capabilities.document_formatting = false
          client.resolved_capabilities.document_range_formatting = false
          mappings(client, bufnr)
        end,
      },
    },
    yamlls = { filetypes = { "yaml" } },
    tsserver = {
      filetypes = { "typescript", "javascript" },
      setup = {
        on_attach = function(client, bufnr)
          client.resolved_capabilities.document_formatting = false
          client.resolved_capabilities.document_range_formatting = false
          mappings(client, bufnr)
        end,
      },
    },
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

  -- Global installer function
  _G.vimrc = _G.vimrc or {}
  _G.vimrc.lsp_installed = _G.vimrc.lsp_installed or {}
  function _G.vimrc.lsp_install(name)
    if _G.vimrc.lsp_installed[name] then
      return
    end

    local server_is_found, server = lsp_installer.get_server(name)
    if server_is_found then
      if not server:is_installed() then
        server:install()
      end
    end

    _G.vimrc.lsp_installed[name] = true
  end

  -- Automatically install default LSP servers on filetype load
  for name, config in pairs(servers) do
    for _, ft in pairs(config.filetypes) do
      utils.augroups({
        ["auto_install_lsp_" .. name .. "_" .. ft] = {
          { "FileType", ft, "lua vimrc.lsp_install('" .. name .. "')" },
        },
      })
    end
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()

  local defaults = {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  lsp_installer.on_server_ready(function(server)
    local options = defaults
    local custom = servers[server.name]

    if custom and custom.setup then
      options = vim.tbl_extend("force", options, custom.setup)
    end

    server:setup(options)
  end)

  -- ---------------------------------------------------
  -- null-ls: for formatters and linters outside LSP
  -- ---------------------------------------------------
  local null_ls = require("null-ls")

  local sources = {
    -- javascript & typescript
    null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.code_actions.eslint_d,

    -- golang
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.diagnostics.golangci_lint,

    -- lua
    null_ls.builtins.formatting.stylua,

    -- git
    null_ls.builtins.code_actions.gitsigns,
  }

  null_ls.setup({
    sources = sources,
    on_attach = function(client, bufnr)
      -- Do not enable textDocument/completion capability on null-ls.
      -- By disabling this capability the autocompletion plugin stops
      -- throwing the error:
      --   "method textDocument/completion is not supported by any of the servers registered for the current buffer"
      -- this happens because null-ls is attached to every buffer, but we don't want this capability since
      -- it's only provided by actual LSP servers.
      client.resolved_capabilities.completion = false
      on_attach(client, bufnr)
    end,
    capabilities = capabilities,
  })
end
