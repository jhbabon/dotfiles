return function()
  local lualine = "auto"

  -- everforest
  vim.g.everforest_background = "hard"
  vim.g.everforest_enable_italic = true
  vim.g.everforest_better_performance = true

  -- rose-pine colorscheme
  require("rose-pine").setup({
    dark_variant = "moon",
  })
  lualine = "rose-pine"

  -- Kanagawa
  -- require("kanagawa").setup({})
  -- lualine = "kanagawa"

  -- Setup the final colorscheme
  require("lualine").setup({
    sections = {
      lualine_z = { "aerial", "location" },
    },
    inactive_sections = {
      lualine_b = { "diff" },
    },
    options = {
      theme = lualine,
      -- globalstatus = true, -- new in neovim 0.7
    },
  })

  vim.opt.background = "dark"
  vim.cmd([[colorscheme rose-pine]])
end
