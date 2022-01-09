-- Experimental port of scout.vim to lua
-- TODO: More docs!
-- TODO: Review signals management
-- TODO: debug mode
local fmt = string.format
local config = require("scout.config").config
local window = require("scout.window")
local u = require("scout.utils")

local new_tty = "?1049h"
local return_tty = "?1049l"
local jobs = {}

local M = {}

local function tmpfile()
  local f = {}
  f.name = os.tmpname()
  local tmp = io.open(f.name, "w")

  f.write = function(...)
    tmp:write(...)
    tmp:flush()
  end

  f.close = function()
    tmp:close()
    os.remove(f.name)
  end

  return f
end

local function noop() end

local function build_list_cmd(cfg)
  if u.is_present(cfg.list_cmd) then
    return {
      cmd = cfg.list_cmd,
      close = noop,
    }
  end

  local list = ""
  if type(cfg.list) == "string" then
    list = cfg.list
  elseif type(cfg.list) == "table" then
    list = table.concat(cfg.list, "\n")
  end

  if u.is_empty(list) then
    return {
      cmd = nil,
      close = noop,
    }
  end

  local tmp = tmpfile()
  tmp.write(list)

  local cmd = fmt("cat %s", tmp.name)

  return {
    cmd = cmd,
    close = tmp.close,
  }
end

local function build_cmd(list_cmd, cmd, search)
  local c = fmt("%s | %s", list_cmd, cmd)
  if u.is_present(search) then
    c = fmt('%s -s "%s"', c, vim.fn.expand(search))
  end

  return c
end

local function mappings(job_id, bufnr)
  local opts = { noremap = true, silent = true }
  local signal = function(sig)
    return fmt([[<c-\><c-n>:lua require('scout').signal(%d, "%s")<cr>]], job_id, sig)
  end
  vim.api.nvim_buf_set_keymap(bufnr, "t", "<c-v>", signal("c-v"), opts)
  vim.api.nvim_buf_set_keymap(bufnr, "t", "<c-x>", signal("c-x"), opts)
  vim.api.nvim_buf_set_keymap(bufnr, "t", "<c-t>", signal("c-t"), opts)
  vim.api.nvim_buf_set_keymap(bufnr, "t", "<c-c>", signal("exit"), opts)
  vim.api.nvim_buf_set_keymap(bufnr, "t", "<esc>", signal("exit"), opts)
end

function M.run(cfg)
  local list = build_list_cmd(cfg)
  local search = cfg.search
  local done = cfg.done
  local title = cfg.title

  assert(list.cmd, "list_cmd or list are missing")
  assert(done, "done function is missing")

  local cmd = build_cmd(list.cmd, config.cmd, search)

  local origin_id = vim.fn.win_getid()
  local win = window.open(title)
  local collect_output = false
  local raw_output = ""

  local function on_stdout(_, data, _)
    local output = data[1]
    if u.is_present(output) then
      if string.match(output, return_tty) then
        collect_output = true
      end

      if collect_output then
        raw_output = output
      end
    end
  end

  local function on_exit(term_id, _, _)
    collect_output = false

    win.close()
    vim.fn.win_gotoid(origin_id)
    list.close()

    local job = jobs[term_id] or { signal = "enter" }
    local signal = job.signal
    jobs[term_id] = nil

    local selection = ""
    if signal ~= "exit" then
      -- clean up control characters
      selection = vim.fn.substitute(raw_output, "[[:cntrl:]]", "", "g")

      -- Remove the escape sequences used to change the terminal: ^[[1049l, etc
      selection = vim.fn.substitute(selection, "^[[:escape]]", "", "g")
      selection = vim.fn.substitute(selection, "^[" .. return_tty, "", "g")
      selection = vim.fn.substitute(selection, "^[" .. new_tty, "", "g")
    end

    done(selection, job.signal)
  end

  local options = {
    on_exit = on_exit,
    on_stdout = on_stdout,
  }

  local job_id = vim.fn.termopen(cmd, options)

  jobs[job_id] = { signal = "enter" }

  mappings(job_id, win.display.buffer)

  vim.cmd("startinsert")
end

function M.signal(job_id, signal)
  jobs[job_id] = { signal = signal }

  if signal == "exit" then
    vim.fn.chanclose(job_id)
  else
    vim.fn.chansend(job_id, "\n")
  end
end

return M
