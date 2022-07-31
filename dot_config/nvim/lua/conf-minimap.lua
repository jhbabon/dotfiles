return function()
  vim.g.minimap_close_filetypes = { "startify", "netrw", "vim-plug", "fugitive", "git", "which_key", "lspinfo" }

  local keychain = require("keychain")
  keychain.set("n", "<leader>mt", ":MinimapToggle<cr>", { silent = true, hint = { "minimap", "toggle" } })
  keychain.set("n", "<leader>mr", ":MinimapRefresh<cr>", { silent = true, hint = { "minimap", "refresh" } })
end
