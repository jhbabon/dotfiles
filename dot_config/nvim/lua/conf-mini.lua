-- Mini plugins:
-- * Show indent lines
-- * Autocompletion
return function()
  require("mini.indentscope").setup({
    -- symbol = "‧",
    symbol = [[·]], -- Middle Dot (U+00B7)
  })

  -- add nice icons to LSP symbols
  local lspkind = require("lspkind")
  if lspkind.init then
    lspkind.init({})
  else
    lspkind.setup({})
  end

  -- see conf-lsp for custom setup per LSP server
  require("mini.completion").setup({
    lsp_completion = { source_func = "omnifunc", auto_setup = false },
  })
end
