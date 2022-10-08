if vim.g.mylsp_marksman_loaded then
  return
end
vim.g.mylsp_marksman_loaded = true

require("lspconfig")["marksman"].setup({
  capabilities = require("conf-lsp.capabilities"),
})
