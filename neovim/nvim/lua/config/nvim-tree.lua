return function()
  require("nvim-tree").setup({
    disable_netrw = true,
    hijack_netrw = false,
    view = {
      auto_resize = true,
    },
  })
  local keychain = require("keychain")

  keychain.nmap("<leader>ft", [[:NvimTreeToggle<cr>]], { hint = { "files", "explorer" } })
end
