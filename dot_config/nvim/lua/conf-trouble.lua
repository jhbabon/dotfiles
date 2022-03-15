return function()
  require("trouble").setup({})

  local keychain = require("keychain")

  keychain.nmap(
    "<leader>dw",
    [[<cmd>Trouble workspace_diagnostics<cr>]],
    { hint = { "diagnostics", "workspace diagnostics" } }
  )
  keychain.nmap(
    "<leader>dd",
    [[<cmd>Trouble document_diagnostics<cr>]],
    { hint = { "diagnostics", "document diagnostics" } }
  )
  keychain.nmap("<leader>qf", [[<cmd>Trouble quickfix<cr>]], { hint = { "list", "quickfix" } })
  keychain.nmap("<leader>ql", [[<cmd>Trouble loclist<cr>]], { hint = { "list", "loclist" } })
end
