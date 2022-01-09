--- Utilities for LSP integration
-- @module lsp
local lsp = {}
local cache = {}

-- imports
local keychain = require("keychain")

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

function lsp.format_on_save(client, _)
  if client.resolved_capabilities.document_formatting then
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
  end
end

function lsp.mappings(_, bufnr)
  -- Normal mappings
  local function map(...)
    keychain.nmap_buf(bufnr, ...)
  end
  map("]e", [[cmd>lua vim.diagnostic.goto_next()<cr>]], { hint = { "lsp", "next diagnostic" } })
  map("[e", [[cmd>lua vim.diagnostic.goto_prev()<cr>]], { hint = { "lsp", "previous diagnostic" } })
  map("<leader>li", [[<cmd>lua vim.lsp.buf.implementation()<cr>]], { hint = { "lsp", "go to implementation" } })
  map("<leader>lh", [[<cmd>lua vim.lsp.buf.hover()<cr>]], { hint = { "lsp", "hover" } })
  map("<leader>ls", [[<cmd>lua vim.lsp.buf.signature_help()<cr>]], { hint = { "lsp", "signature" } })
  map("<leader>ln", [[<cmd>lua vim.lsp.buf.rename()<cr>]], { hint = { "lsp", "rename" } })
  map("<leader>lg", [[<cmd>lua vim.diagnostic.open_float()<cr>]], { hint = { "lsp", "line diagnostic" } })
  map("<leader>lc", [[<cmd>lua vim.lsp.buf.code_action()<cr>]], { hint = { "lsp", "code action" } })
  map("<leader>lf", [[<cmd>lua vim.lsp.buf.formatting_sync()<cr>]], { hint = { "lsp", "format file" } })

  -- Use Trouble for references and definitions
  map("<leader>lr", [[<cmd>Trouble lsp_references<cr>]], { hint = { "lsp", "references" } })
  map("<leader>lt", [[<cmd>Trouble lsp_type_definitions<cr>]], { hint = { "lsp", "go to type definition" } })
  map("<leader>ld", [[<cmd>Trouble lsp_definitions<cr>]], { hint = { "lsp", "go to definition" } })

  -- Visual mappings
  keychain.vmap_buf(
    bufnr,
    "<leader>lc",
    [[<cmd>lua vim.lsp.buf.range_code_action()<cr>]],
    { hint = { "lsp", "code action" } }
  )
end

function lsp.on_attach(client, bufnr)
  lsp.format_on_save(client, bufnr)
  lsp.mappings(client, bufnr)
end

return lsp
