return function()
  require("litee.lib").setup({
    tree = {
      icon_set = "nerd",
    },
    panel = {
      orientation = "left",
    },
  })
  require("litee.calltree").setup({})
  require("litee.filetree").setup({})

  local keychain = require("keychain")
  keychain.set("n", "<leader>ft", [[:LTPopOutFiletree<cr>]], { hint = { "files", "explorer" } })
end
