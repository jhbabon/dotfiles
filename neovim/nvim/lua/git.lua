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

local keymap = {}
keymap.g = {
  name = '+git',
  -- fugitive mappings
  s = {':Gstatus<cr>', 'status'},
  c = {':Git commit<cr>', 'commit'},
  l = {':Glog<cr>', 'log'},
  d = {':Gdiff<cr>', 'diff'},

  h = {
    name = '+hunk',
    -- gitsigns
    s = {'<cmd>lua require("gitsigns").stage_hunk()<cr>', 'stage'},
    u = {'<cmd>lua require("gitsigns").undo_stage_hunk()<cr>', 'unstage'},
    r = {'<cmd>lua require("gitsigns").reset_hunk()<cr>', 'reset'},
    R = {'<cmd>lua require("gitsigns").reset_buffer()<cr>', 'reset buffer'},
    p = {'<cmd>lua require("gitsigns").preview_hunk()<cr>', 'preview'},
    b = {'<cmd>lua require("gitsigns").blame_line()<cr>', 'blame'},
  }
}

require('whichkey_setup').register_keymap('leader', keymap)
