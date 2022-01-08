return function()
  vim.g.rose_pine_bold_vertical_split_line = true
  -- variants: 'main' | 'moon' | 'dawn'
  vim.g.rose_pine_variant = "dawn"

  -- Colors for indent lines
  local palette = require("rose-pine.palette")
  vim.cmd([[highlight IndentBlanklineContextChar guifg=]] .. palette.gold .. [[ gui=nocombine]])
end
