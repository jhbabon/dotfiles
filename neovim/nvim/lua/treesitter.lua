-- NOTE: some parsers need node installed
require('nvim-treesitter.configs').setup {
  ensure_installed = 'maintained',
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
  incremental_selection = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  -- TODO: look into textobjects config
}

-- use treesitter folding module
vim.wo.foldlevel = 5
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
