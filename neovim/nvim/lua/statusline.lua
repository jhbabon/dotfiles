-- none of the statusline plugins I tried are amazin. I might just go and roll my own
require('lualine').setup {
  options = {
    theme = 'palenight',
  },
  sections = {
    lualine_b = { 'branch' },
    lualine_c = { {'filename', file_status = true, full_path = true} },
    lualine_y = { {'diff', colored = false}, {'diagnostics', colored = false, sources = {'nvim_lsp'}} },
  },
}
