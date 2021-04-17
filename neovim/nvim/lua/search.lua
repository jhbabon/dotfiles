local h = require('helpers')

-- vim-grepper
h.exec([[let g:grepper = { 'tools': ['rg', 'git', 'grep'] }]])

h.nmap('<leader>sw', [[:Grepper -noprompt -cword<cr>]], { hint = 'search: current word' })
h.nmap('<leader>sq', [[:Grepper -query<space>]], { hint = 'search: query' })
h.nmap('<leader>sc', ':nohl<cr>', { hint = 'search: clear highlight' })

h.exec([[packadd! vim-grepper]])
