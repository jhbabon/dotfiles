return function()
  -- require("nvim-treesitter.install").prefer_git = true
  require("nvim-treesitter.configs").setup({
    ensure_installed = "maintained",
    sync_install = false,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
      enable = true,
    },
    indent = {
      enable = true,
    },
  })

  -- Use treesitter's folding module
  vim.opt.foldlevel = 5
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
end
