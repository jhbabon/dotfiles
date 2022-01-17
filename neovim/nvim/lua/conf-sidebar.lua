return function()
  require("sidebar-nvim").setup({
    open = false,
    sections = { "todos", "git", "diagnostics", "symbols" },
  })

  local keychain = require("keychain")
  keychain.nmap("<leader>ds", [[:SidebarNvimToggle<cr>]], { hint = { "diagnostics", "sidebar" } })
end
