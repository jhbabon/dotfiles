return function()
  -- material colorscheme
  -- variants: 'darker' | 'lighter' | 'oceanic' | 'palenight' | 'deep ocean'
  vim.g.material_style = "palenight"

  require("material").setup({
    italics = {
      comments = true,
      functions = true,
      keywords = true,
    },
  })

  local keychain = require("keychain")
  keychain.nmap(
    "<leader>ms",
    [[:lua require("material.functions").toggle_style()<cr>]],
    { hint = { "material", "switch style" } }
  )

  require("lualine").setup({
    options = { theme = "material-nvim" },
  })

  -- Setup the final colorscheme
  vim.cmd([[colorscheme material]])
end
