-- Mini plugins:
-- * Show indent lines
-- * Autocompletion
return function()
  require("mini.indentscope").setup({
    symbol = "‧",
  })

  -- add nice icons to LSP symbols
  local lspkind = require("lspkind")
  if lspkind.init then
    lspkind.init({})
  else
    lspkind.setup({})
  end

  require("mini.completion").setup({})
end
