local h = require('helpers')
h.nmap('<leader>qn', [[:cn<cr>]], { silent = true, hint = 'quickfix: next' })
h.nmap('<leader>qp', [[:cp<cr>]], { silent = true, hint = 'quickfix: previous' })
