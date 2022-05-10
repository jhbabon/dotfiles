return function()
  local lualine = "auto"

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
  -- lualine = "rose-pine"
  -- local keychain = require("keychain")
  -- keychain.nmap("<leader>cs", [[:lua require("rose-pine").toggle()<cr>]], { hint = { "colorscheme", "switch style" } })

  -- Kanagawa
  require("kanagawa").setup({})
  lualine = "kanagawa"

  -- Setup the final colorscheme
  require("lualine").setup({
    sections = {
      lualine_c = { "filename", "aerial" },
    },
    options = {
      theme = lualine,
      -- globalstatus = true, -- new in neovim 0.7
    },
  })
  -- vim.cmd([[colorscheme rose-pine]])
  vim.cmd([[colorscheme kanagawa]])
end
