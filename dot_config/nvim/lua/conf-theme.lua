return function()
  -- everforest
  -- vim.g.everforest_background = "hard"
  -- vim.g.everforest_enable_italic = true
  -- vim.g.everforest_better_performance = true

  -- kanagawa
  -- require("kanagawa").setup({})

  -- rose-pine colorscheme
  require("rose-pine").setup({
    dark_variant = "moon",
  })
  -- Mini statusline highlight groups
  local palette = require("rose-pine.palette")
  local mini = {
    MiniStatuslineModeNormal = { bg = palette.rose, fg = palette.base, bold = true },
    MiniStatuslineModeInsert = { bg = palette.foam, fg = palette.base, bold = true },
    MiniStatuslineModeVisual = { bg = palette.iris, fg = palette.base, bold = true },
    MiniStatuslineModeReplace = { bg = palette.pine, fg = palette.base, bold = true },
    MiniStatuslineModeCommand = { bg = palette.love, fg = palette.base, bold = true },
    MiniStatuslineModeOther = { bg = palette.gold, fg = palette.base, bold = true },
    MiniStatuslineInactive = { bg = palette.base, fg = palette.muted },

    MiniStatuslineDevinfo = { bg = palette.overlay, fg = palette.text },
    MiniStatuslineFilename = { bg = palette.base, fg = palette.text },
    MiniStatuslineFileinfo = { bg = palette.base, fg = palette.muted },
  }

  for group, spec in pairs(mini) do
    vim.api.nvim_set_hl(0, group, spec)
  end

  vim.opt.background = "dark"
  vim.cmd([[colorscheme rose-pine]])
end
