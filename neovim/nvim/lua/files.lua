local keymap = {}
keymap.f = {
  name = '+files',
  t = {':Explore<cr>', 'tree explorer'}, -- TODO: check nvim-tree.lua
  p = {[[:let @+ = expand("%")<cr>]], 'copy current file path'},
}

keymap.b = { name = '+buffers' }

-- scout.vim
if vim.fn.executable('scout') then
  vim.g.scout_window_type = 'floating'

  if vim.fn.executable('rg') then
    vim.g.scout_find_files_command = [[rg --files --hidden --follow --glob "!.git/*" 2>/dev/null]]
  end

  keymap.f.f = {':ScoutFiles<cr>', 'open file'}
  keymap.f.d = {':ScoutFiles %:h<cr>', 'open file in current dir'}

  keymap.b.b = {':ScoutBuffers<cr>', 'open buffer'}
  keymap.b.d = {':ScoutBuffers %:h<cr>', 'open buffer in current dir'}

  vim.cmd [[packadd! scout.vim]]
end

require('whichkey_setup').register_keymap('leader', keymap)
