return function()
  -- material colorscheme
  -- variants: 'darker' | 'lighter' | 'oceanic' | 'palenight' | 'deep ocean'
  vim.g.material_style = "lighter"

  require("material").setup({
    italics = {
      comments = true,
      functions = true,
      -- keywords = true,
    },
  })

  -- rose-pine colorscheme
  vim.g.rose_pine_bold_vertical_split_line = true
  -- variants: 'main' | 'moon' | 'dawn'
  vim.g.rose_pine_variant = "dawn"

  -- Colors for indent lines
  local palette = require("rose-pine.palette")
  vim.cmd([[highlight IndentBlanklineContextChar guifg=]] .. palette.gold .. [[ gui=nocombine]])

  -- Setup the final colorscheme
  vim.cmd([[colorscheme rose-pine]])
end
