return function()
  -- material colorscheme
  -- variants: 'darker' | 'lighter' | 'oceanic' | 'palenight' | 'deep ocean'
  -- vim.g.material_style = "palenight"

  -- require("material").setup({
  --   italics = {
  --     comments = true,
  --     functions = true,
  --     keywords = true,
  --   },
  -- })

  -- everforest
  vim.g.everforest_background = "hard"
  vim.g.everforest_enable_italic = true
  vim.g.everforest_better_performance = true

  -- rose-pine colorscheme
  -- @usage 'main' | 'moon' | 'dawn'
  vim.g.rose_pine_variant = "moon"
  local keychain = require("keychain")
  keychain.nmap("<leader>cs", [[:lua require("rose-pine").toggle()<cr>]], { hint = { "colorscheme", "switch style" } })

  require("lualine").setup({
    options = { theme = "rose-pine" },
  })

  -- Setup the final colorscheme
  vim.cmd([[colorscheme rose-pine]])
end
