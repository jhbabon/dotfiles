-- Mini plugins:
-- * Show indent lines
-- * Autocompletion
return function()
  require("mini.indentscope").setup({
    symbol = "‧",
  })

  -- add nice icons to LSP symbols
  require("lspkind").init({})
  require("mini.completion").setup({})
end
