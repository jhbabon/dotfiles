if vim.g.mylsp_tsserver_loaded then
  return
end
vim.g.mylsp_tsserver_loaded = true

local config = {}
config.capabilities = vim.tbl_extend(
  "force",
  require("conf-lsp.capabilities"),
  {
    -- disable formatting
    documentFormattingProvider = false,
    documentrangeFormattingProvider = false,
  }
)

local function organize_imports(bufnr)
  local params = {
    command = "_typescript.organizeImports",
    arguments = { bufnr },
    title = "",
  }
  vim.lsp.buf.execute_command(params)
end

config.on_attach = function(_, bufnr)
  vim.keymap.set("n", "<LocalLeader>O", function() organize_imports(bufnr) end, { buffer = bufnr })
end

require("lspconfig").tsserver.setup(config)
