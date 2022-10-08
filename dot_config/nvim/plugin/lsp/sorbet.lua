if vim.g.mylsp_sorbet_loaded then
  return
end
vim.g.mylsp_sorbet_loaded = true

local bins = require("conf-lsp.bins")
if not bins.sorbet then
  -- It's not present, nothing to do
  return
end

require("lspconfig").sorbet.setup({
  cmd = { "bin/srb", "tc", "--lsp" },
  capabilities = require("conf-lsp.capabilities"),
})
