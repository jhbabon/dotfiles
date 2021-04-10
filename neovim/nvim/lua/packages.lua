----------------------------------------------------
-- Packages
----------------------------------------------------
-- TODO: Load only on demand
vim.cmd [[packadd paq-nvim]]
local paq = require('paq-nvim').paq

-- Let paq-nvim manage itself
paq {'savq/paq-nvim', opt = true}

paq {'nvim-lua/plenary.nvim'}

-- TODO: Find/reuse packages for
-- git: signs (?), commits, etc
-- comments: add, remove, etc

paq {'nvim-treesitter/nvim-treesitter', run = function() vim.cmd('TSUpdate') end}

paq {'liuchengxu/vim-which-key'}
paq {'AckslD/nvim-whichkey-setup.lua'}

paq {'tpope/vim-fugitive'}
paq {'tpope/vim-surround'}
paq {'tpope/vim-eunuch'}

paq {'lewis6991/gitsigns.nvim'}

paq {'windwp/nvim-autopairs'}

paq {'wfxr/minimap.vim', opt = true}

-- colorschemes
paq {'RRethy/nvim-base16'}
