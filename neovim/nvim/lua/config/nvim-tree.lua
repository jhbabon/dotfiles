local function config()
  require('nvim-tree').setup {
    disable_netrw = false,
    hijack_netrw = false,
  }
end

return config
