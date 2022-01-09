return function()
  local keychain = require("keychain")

  keychain.nmap("<leader>gs", [[:Git<cr>]], { hint = { "git", "status" } })
  keychain.nmap("<leader>gc", [[:Git commit<cr>]], { hint = { "git", "commit" } })
  keychain.nmap("<leader>gl", [[:Gclog<cr>]], { hint = { "git", "log" } })
  keychain.nmap("<leader>gd", [[:Gdiff<cr>]], { hint = { "git", "diff" } })
end
