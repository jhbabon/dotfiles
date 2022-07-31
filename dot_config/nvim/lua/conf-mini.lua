-- Mini plugins
-- @see https://github.com/echasnovski/mini.nvim
return function()
  -- Show indent lines
  require("mini.indentscope").setup({
    symbol = [[·]], -- Middle Dot (U+00B7)
  })

  -- Per line commenting. Replacement of tpope/vim-commentary
  require("mini.comment").setup({})

  -- LSP autocompletion.
  require("mini.completion").setup({})

  -- Automatic highlighting of word under cursor
  require("mini.cursorword").setup({})

  -- Minimal and fast module for smarter jumping to a single character
  require("mini.jump").setup({})

  -- Minimal and fast Lua plugin for jumping (moving cursor)
  -- within visible lines via iterative label filtering
  require("mini.jump2d").setup({})

  -- Autopair plugin
  -- Replaces windwp/nvim-autopairs
  require("mini.pairs").setup({})
end
