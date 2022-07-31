-- Mini plugins:
-- * Show indent lines
-- * Autocompletion
return function()
  require("mini.indentscope").setup({
    -- symbol = "‧",
    symbol = [[·]], -- Middle Dot (U+00B7)
  })


  -- LSP autocompletion.
  require("mini.completion").setup({})
end
