local fmt = string.format
local config = require('scout').config
local window = require('scout/window')

local return_tty = '?1049l'
local jobs = {}

local M = {}

local function mappings(job_id, bufnr)
  local opts = { noremap = true, silent = true }
  local signal = function(sg)
    return fmt([[<c-\><c-n>:lua require('scout.core').signal(%d, "%s")<cr>]], job_id, sg)
  end
  vim.api.nvim_buf_set_keymap(bufnr, 't', '<c-v>', signal('c-v'), opts)
  vim.api.nvim_buf_set_keymap(bufnr, 't', '<c-x>', signal('c-x'), opts)
  vim.api.nvim_buf_set_keymap(bufnr, 't', '<c-t>', signal('c-t'), opts)
  vim.api.nvim_buf_set_keymap(bufnr, 't', '<c-c>', signal('exit'), opts)
  vim.api.nvim_buf_set_keymap(bufnr, 't', '<esc>', signal('exit'), opts)
end

function M.isempty(s)
  return s == nil or s == ''
end

local function build_cmd(list_cmd, cmd, search)
  local c = fmt('%s | %s', list_cmd, cmd)
  if not M.isempty(search) then
    s = vim.fn.expand(search)
    c = fmt('%s -s "%s"', c, s)
  end

  return c
end

function M.run(cfg)
  local list_cmd = cfg.list_cmd -- TODO: Accept list = {'a', 'b'}
  local search = cfg.search
  local finish = cfg.finish

  assert(list_cmd, 'the list_cmd is missing')
  assert(finish, 'the finish function is missing')

  local cmd = build_cmd(list_cmd, config.cmd, search)

  local origin_id = vim.fn.win_getid()
  local win = window.open('files')
  local collect_output = false
  local raw_output = ''

  local on_stdout = function(term_id, data, event)
    local output = data[1]
    if not M.isempty(output) then
      if collect_output then
        raw_output = output
      end

      if string.match(output, return_tty) then
        collect_output = true
      end
    end
  end

  local on_exit = function(term_id, data, event)
    collect_output = false

    win.close()
    vim.fn.win_gotoid(origin_id)

    local job = jobs[term_id] or { signal = 'enter' }
    jobs[term_id] = nil

    local selection = string.gsub(raw_output or '', '%c', '')
    finish(selection, job.signal)
  end

  local options = {
    on_exit = on_exit,
    on_stdout = on_stdout,
  }

  local job_id = vim.fn.termopen(cmd, options)

  jobs[job_id] = { signal = 'enter' }

  mappings(job_id, win.display.buffer)

  vim.cmd('startinsert')
end

function M.signal(job_id, signal)
  jobs[job_id] = { signal = signal }

  if signal == 'exit' then
    vim.fn.chanclose(job_id)
  else
    vim.fn.chansend(job_id, "\n")
  end
end

return M
