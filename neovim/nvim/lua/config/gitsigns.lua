return function()
  -- remove default keymaps
  require("gitsigns").setup({ keymaps = {} })
  -- add custom keymaps
  local keychain = require("keychain")

  keychain.nmap("]c", "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true, hint = { "git", "next hunk" } })
  keychain.nmap("[c", "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true, hint = { "git", "prev hunk" } })

  keychain.nmap("<leader>hs", [[<cmd>Gitsigns stage_hunk<CR>]], { hint = { "git", "stage hunk" } })
  keychain.vmap("<leader>hs", [[:Gitsigns stage_hunk<CR>]], { hint = { "git", "stage hunk" } })
  keychain.nmap("<leader>hu", [[<cmd>Gitsigns undo_stage_hunk<CR>]], { hint = { "git", "undo stage hunk" } })
  keychain.nmap("<leader>hr", [[<cmd>Gitsigns reset_hunk<CR>]], { hint = { "git", "reset hunk" } })
  keychain.vmap("<leader>hr", [[:Gitsigns reset_hunk<CR>]], { hint = { "git", "reset hunk" } })
  keychain.nmap("<leader>hR", [[<cmd>Gitsigns reset_buffer<CR>]], { hint = { "git", "reset buffer" } })
  keychain.nmap("<leader>hp", [[<cmd>Gitsigns preview_hunk<CR>]], { hint = { "git", "preview hunk" } })
  keychain.nmap("<leader>hb", [[<cmd>lua require("gitsigns").blame_line{full=true}<CR>]], { hint = { "git", "blame" } })
  keychain.nmap("<leader>hS", [[<cmd>Gitsigns stage_buffer<CR>]], { hint = { "git", "stage buffer" } })
  keychain.nmap("<leader>hU", [[<cmd>Gitsigns reset_buffer_index<CR>]], { hint = { "git", "reset buffer index" } })

  -- Text objects
  keychain.map("o", "ih", [[:<C-U>Gitsigns select_hunk<CR>]], { hint = { "git", "" } })
  keychain.map("x", "ih", [[:<C-U>Gitsigns select_hunk<CR>]], { hint = { "git", "" } })
end
