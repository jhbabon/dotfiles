return function()
  require("sidebar-nvim").setup({
    open = false,
    sections = { "todos", "git", "diagnostics", "symbols" },
  })

  local keychain = require("keychain")
  keychain.set("n", "<leader>ds", [[:SidebarNvimToggle<cr>]], { hint = { "diagnostics", "sidebar" } })
end
