-- NOTE: this is actually a "setup" function since the settings
-- have to be set before the vim plugin is loaded
return function()
  vim.g.any_jump_disable_default_keybindings = true
  local keychain = require("keychain")

  keychain.nmap("<leader>jw", [[:AnyJump<cr>]], { hint = { "jump", "current word" } })
  keychain.map("x", "<leader>jw", [[:AnyJumpVisual<cr>]], { hint = { "jump", "current word" } })
  keychain.nmap("<leader>jb", [[:AnyJumpBack<cr>]], { hint = { "jump", "previous file" } })
  keychain.nmap("<leader>jl", [[:AnyJumpLastResults<cr>]], { hint = { "jump", "last results" } })
end
