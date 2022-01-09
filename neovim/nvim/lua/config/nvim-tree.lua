return function()
  require("nvim-tree").setup({
    disable_netrw = true,
    hijack_netrw = false,
    view = {
      auto_resize = true,
    },
  })
end
