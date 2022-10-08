if vim.g.mylsp_rust_analyzer_loaded then
  return
end
vim.g.mylsp_rust_analyzer_loaded = true

require("lspconfig").rust_analyzer.setup({
  capabilities = require("conf-lsp.capabilities"),
  settings = {
    -- to enable rust-analyzer settings visit:
    -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
    ["rust-analyzer"] = {
      -- enable clippy on save
      checkOnSave = {
        command = "clippy",
      },
    },
  }
})
