return function()
  -- variants: 'darker' | 'lighter' | 'oceanic' | 'palenight' | 'deep ocean'
  vim.g.material_style = "lighter"

  require("material").setup({
    italics = {
      comments = true,
      functions = true,
      -- keywords = true,
    },
  })
end
