-- Mini plugins:
return function()
  -- Show indent lines
  require("mini.indentscope").setup({
    -- symbol = "‧",
    symbol = [[·]], -- Middle Dot (U+00B7)
  })

  -- Per line commenting. Replacement of tpope/vim-commentary
  require("mini.comment").setup({})

  -- LSP autocompletion.
  require("mini.completion").setup({})
end
