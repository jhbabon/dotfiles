return function()
  local utils = require("utils")
  local luasnip = require("luasnip")
  require("luasnip.loaders.from_vscode").lazy_load()

  local function check_back_space()
    local col = vim.fn.col(".") - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
      return true
    else
      return false
    end
  end

  -- Expand luasnip on tab
  local function tab_complete()
    if luasnip.expand_or_jumpable() then
      return "<Plug>luasnip-expand-or-jump"
    elseif check_back_space() then
      return "<Tab>"
    end

    return ""
  end

  local function s_tab_complete()
    if luasnip.jumpable(-1) then
      return "<Plug>luasnip-jump-prev"
    end

    return "<S-Tab>"
  end

  vim.keymap.set("i", "<Tab>", tab_complete, { expr = true })
  vim.keymap.set("s", "<Tab>", tab_complete, { expr = true })
  vim.keymap.set("i", "<S-Tab>", s_tab_complete, { expr = true })
  vim.keymap.set("s", "<S-Tab>", s_tab_complete, { expr = true })
  vim.keymap.set("i", "<C-E>", "<Plug>luasnip-next-choice", {})
  vim.keymap.set("s", "<C-E>", "<Plug>luasnip-next-choice", {})

  -- Completion function for luasnip.
  -- Original code: https://github.com/potamides/dotfiles/blob/master/.config/nvim/plugin/snipcomp.lua
  local function into_completion(snippet)
    return {
      word = snippet.trigger,
      menu = snippet.name,
      info = vim.trim(table.concat(vim.tbl_flatten({ snippet.dscr or "", "", snippet:get_docstring() }), "\n")),
      dup = true,
      user_data = "luasnip",
    }
  end

  local function snippet_filter(line_to_cursor, base)
    return function(snippet)
      return not snippet.hidden and vim.startswith(snippet.trigger, base) and snippet.show_condition(line_to_cursor)
    end
  end

  -- Set 'completefunc' or 'omnifunc' to 'v:lua.vim.luasnip.completefunc'
  vim.myluasnip = {}
  function vim.myluasnip.completion(findstart, base)
    local line, col = vim.api.nvim_get_current_line(), vim.api.nvim_win_get_cursor(0)[2]
    local line_to_cursor = line:sub(1, col)
    if findstart == 1 then
      return vim.fn.match(line_to_cursor, "\\k*$")
    end

    local snippets = vim.list_extend(vim.list_slice(luasnip.get_snippets("all")), luasnip.get_snippets(vim.bo.filetype))
    snippets = vim.tbl_filter(snippet_filter(line_to_cursor, base), snippets)
    snippets = vim.tbl_map(into_completion, snippets)

    table.sort(snippets, function(s1, s2)
      return s1.word < s2.word
    end)
    return snippets
  end

  local luasnip_completion_expand = utils.au("luasnip_completion_expand")
  function luasnip_completion_expand.CompleteDone()
    if vim.v.completed_item.user_data == "luasnip" and luasnip.expandable() then
      luasnip.expand({})
    end
  end

  -- Set the completion function as the default omnifunc
  vim.opt.omnifunc = "v:lua.vim.myluasnip.completion"
end
