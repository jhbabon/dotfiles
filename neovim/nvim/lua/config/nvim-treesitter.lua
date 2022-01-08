-- TODO: Review configuration
return function()
  -- require("nvim-treesitter.install").prefer_git = true
  require('nvim-treesitter.configs').setup {
    ensure_installed = 'maintained',
    sync_install = false,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false, -- TODO: Review
    },
    incremental_selection = {
      enable = true,
    },
    indent = {
      enable = true,
    },
  }
end
