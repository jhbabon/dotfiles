-- Patch needed by lspconfig and lspsaga
if vim.lsp.util._trim == nil then
  vim.lsp.util._trim = vim.lsp.util._trim_and_pad
end

local h = require('helpers')

-- nvim-slpconfig
local nvim_lsp = require('lspconfig')
local function on_attach(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings
  local opts = { noremap = true, silent = true }
  h.nmap_buf(bufnr, ']e', [[cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_next()<cr>]], { silent = true, hint = 'lsp: next diagnostic' })
  h.nmap_buf(bufnr, '[e', [[cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_prev()<cr>]], { silent = true, hint = 'lsp: previous diagnostic' })
  h.nmap_buf(bufnr, '<leader>ld', [[<cmd>lua vim.lsp.buf.definition()<cr>]], { silent = true, hint = 'lsp: go to definition' })
  h.nmap_buf(bufnr, '<leader>li', [[<cmd>lua vim.lsp.buf.implementation()<cr>]], { silent = true, hint = 'lsp: go to implementation' })
  h.nmap_buf(bufnr, '<leader>lt', [[<cmd>lua vim.lsp.buf.type_definition()<cr>]], { silent = true, hint = 'lsp: go to type definition' })
  h.nmap_buf(bufnr, '<leader>lh', [[<cmd>lua require('lspsaga.hover').render_hover_doc()<cr>]], { silent = true, hint = 'lsp: hover' })
  h.nmap_buf(bufnr, '<leader>ls', [[<cmd>lua require('lspsaga.signaturehelp').signature_help()<cr>]], { silent = true, hint = 'lsp: signature' })
  h.nmap_buf(bufnr, '<leader>lr', [[<cmd>lua require('lspsaga.rename').rename()<cr>]], { silent = true, hint = 'lsp: rename' })
  h.nmap_buf(bufnr, '<leader>lf', [[<cmd>lua vim.lsp.buf.references()<cr>]], { silent = true, hint = 'lsp: references' })
  h.nmap_buf(bufnr, '<leader>lg', [[<cmd>lua require('lspsaga.diagnostic').show_line_diagnostics()<cr>]], { silent = true, hint = 'lsp: line diagnostic' })
  h.nmap_buf(bufnr, '<leader>lc', [[<cmd>lua require('lspsaga.codeaction').code_action()<cr>]], { silent = true, hint = 'lsp: code action' })

  -- Visual mappings
  h.map_buf(bufnr, 'v', '<leader>lc', [[<cmd>lua require('lspsaga.codeaction').range_code_action()<cr>]], { silent = true, hint = 'lsp: code action' })
end

local servers = {
  'gopls',
  'rust_analyzer',
  'tsserver',
  'solargraph',
}
for _, lsp in pairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

-- lspsaga.nvim
require('lspsaga').init_lsp_saga()
