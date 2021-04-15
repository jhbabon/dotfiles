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
  h.map_buf(bufnr, 'n', ']e', [[cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_next()<cr>]], opts)
  h.map_buf(bufnr, 'n', '[e', [[cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_prev()<cr>]], opts)

  h.map_buf(bufnr, 'n', '<leader>ld', [[<cmd>lua vim.lsp.buf.definition()<cr>]], opts)
  h.map_buf(bufnr, 'n', '<leader>li', [[<cmd>lua vim.lsp.buf.implementation()<cr>]], opts)
  h.map_buf(bufnr, 'n', '<leader>lt', [[<cmd>lua vim.lsp.buf.type_definition()<cr>]], opts)
  h.map_buf(bufnr, 'n', '<leader>lh', [[<cmd>lua require('lspsaga.hover').render_hover_doc()<cr>]], opts)
  h.map_buf(bufnr, 'n', '<leader>ls', [[<cmd>lua require('lspsaga.signaturehelp').signature_help()<cr>]], opts)
  h.map_buf(bufnr, 'n', '<leader>lr', [[<cmd>lua require('lspsaga.rename').rename()<cr>]], opts)
  h.map_buf(bufnr, 'n', '<leader>lf', [[<cmd>lua vim.lsp.buf.references()<cr>]], opts)
  h.map_buf(bufnr, 'n', '<leader>lg', [[<cmd>lua require('lspsaga.diagnostic').show_line_diagnostics()<cr>]], opts)
  h.map_buf(bufnr, 'n', '<leader>lc', [[<cmd>lua require('lspsaga.codeaction').code_action()<cr>]], opts)

  -- Visual mappings
  h.map_buf(bufnr, 'v', '<leader>lc', [[<cmd>lua require('lspsaga.codeaction').range_code_action()<cr>]], opts)
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
