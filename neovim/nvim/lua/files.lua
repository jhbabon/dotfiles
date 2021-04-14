local h = require('helpers')

local keymap = {}
keymap.f = {
  name = '+files',
  t = {':Explore<cr>', 'tree explorer'}, -- TODO: check nvim-tree.lua
  p = {[[:let @+ = expand("%")<cr>]], 'copy current file path'},
}

keymap.b = { name = '+buffers' }

-- nvim-scout
if vim.fn.executable('scout') then
  if vim.fn.executable('rg') then
    require('scout').setup {
      files = {
        finder = [[rg --files --hidden --follow --glob "!.git/*" 2>/dev/null]]
      }
    }
  end

  h.nmap('<leader>ff', [[:lua require('scout.files').run()<cr>]], {silent = true})
  h.nmap('<leader>fd', [[:lua require('scout.files').run({ search = '%:h' })<cr>]], {silent = true})
  h.nmap('<leader>bb', [[:lua require('scout.buffers').run()<cr>]], {silent = true})
  h.nmap('<leader>bd', [[:lua require('scout.buffers').run({ search = '%:h' })<cr>]], {silent = true})
end

require('whichkey_setup').register_keymap('leader', keymap)
