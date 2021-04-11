-- Patch needed by lspconfig and lspsaga
if vim.lsp.util._trim == nil then
  vim.lsp.util._trim = vim.lsp.util._trim_and_pad
end

local h = require('helpers')

local keymap = {}
keymap.l = {
  name = '+lsp',
  d = {[[<cmd>lua vim.lsp.buf.definition()<cr>]], 'go to definition'},
  i = {[[<cmd>lua vim.lsp.buf.implementation()<cr>]], 'go to implementation'},
  t = {[[<cmd>lua vim.lsp.buf.type_definition()<cr>]], 'go to type definition'},
  h = {[[<cmd>lua require('lspsaga.hover').render_hover_doc()<cr>]], 'hover'},
  s = {[[<cmd>lua require('lspsaga.signaturehelp').signature_help()<cr>]], 'signature'},
  r = {[[<cmd>lua require('lspsaga.rename').rename()<cr>]], 'rename'},
  f = {[[<cmd>lua vim.lsp.buf.references()<cr>]], 'references'},
  g = {[[<cmd>lua require('lspsaga.diagnostic').show_line_diagnostics()<cr>]], 'diagnostic'},
  c = {[[<cmd>lua require('lspsaga.codeaction').code_action()<cr>]], 'code action'},
}

local visual_keymap = {}
visual_keymap.l = {
  name = '+lsp',
  c = {[[<cmd>lua require('lspsaga.codeaction').range_code_action()<cr>]], 'code action'},
}

-- nvim-slpconfig
local nvim_lsp = require('lspconfig')
local function on_attach(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings
  local opts = { noremap = true, silent = true }
  h.map_buf(bufnr, 'n', ']e', [[cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_next()<cr>]], opts)
  h.map_buf(bufnr, 'n', '[e', [[cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_prev()<cr>]], opts)

  require('whichkey_setup').register_keymap('leader', keymap, { noremap = true, silent = true, bufnr = bufnr })
  require('whichkey_setup').register_keymap('visual', visual_keymap, { noremap = true, silent = true, bufnr = bufnr })
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
