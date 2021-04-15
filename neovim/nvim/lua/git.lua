local h = require('helpers')

-- vim.cmd('highlight link GitSignsAdd Title')
-- vim.cmd('highlight link GitSignsDelete WarningMsg')
-- vim.cmd('highlight link GitSignsChange ModeMsg')

-- TODO: better icons
require('gitsigns').setup {
    signs = {
      add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
      change       = {hl = 'GitSignsChange', text = '|', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
      delete       = {hl = 'GitSignsDelete', text = '-', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
      topdelete    = {hl = 'GitSignsDelete', text = '^', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
      changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    },
    keymaps = {
        -- Default keymap options
        noremap = true,
        buffer = true,

        ['n ]c'] = { expr = true, [[&diff ? ']c' : '<cmd>lua require("gitsigns").next_hunk()<cr>']]},
        ['n [c'] = { expr = true, [[&diff ? '[c' : '<cmd>lua require("gitsigns").prev_hunk()<cr>']]},

        -- Text objects
        ['o ih'] = [[:<c-u>lua require('gitsigns').select_hunk()<cr>]],
        ['x ih'] = [[:<c-u>lua require('gitsigns').select_hunk()<cr>]],
    },
}

-- fugitive
h.nmap('<leader>gs', ':Gstatus<cr>', { silent = true, hint = 'git: status' })
h.nmap('<leader>gc', ':Git commit<cr>', { silent = true, hint = 'git: commit' })
h.nmap('<leader>gl', ':Glog<cr>', { silent = true, hint = 'git: log' })
h.nmap('<leader>gd', ':Gdiff<cr>', { silent = true, hint = 'git: diff' })

-- gitsigns
h.nmap('<leader>ghs', [[<cmd>lua require('gitsigns').stage_hunk()<cr>]], { silent = true })
h.nmap('<leader>ghu', [[<cmd>lua require('gitsigns').undo_stage_hunk()<cr>]], { silent = true })
h.nmap('<leader>ghr', [[<cmd>lua require('gitsigns').reset_hunk()<cr>]], { silent = true })
h.nmap('<leader>ghR', [[<cmd>lua require('gitsigns').reset_buffer()<cr>]], { silent = true })
h.nmap('<leader>ghp', [[<cmd>lua require('gitsigns').preview_hunk()<cr>]], { silent = true })
h.nmap('<leader>ghb', [[<cmd>lua require('gitsigns').blame_line()<cr>]], { silent = true })
