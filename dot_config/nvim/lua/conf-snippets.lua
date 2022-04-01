return function()
  local luasnip = require("luasnip")
  require("luasnip.loaders.from_vscode").lazy_load()

  local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end

  local function check_back_space()
    local col = vim.fn.col(".") - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
      return true
    else
      return false
    end
  end

  _G.tab_complete = function()
    if luasnip.expand_or_jumpable() then
      return t("<Plug>luasnip-expand-or-jump")
    elseif check_back_space() then
      return t("<Tab>")
    end

    return ""
  end
  _G.s_tab_complete = function()
    if luasnip.jumpable(-1) then
      return t("<Plug>luasnip-jump-prev")
    else
      return t("<S-Tab>")
    end
    return ""
  end

  vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
  vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", { expr = true })
  vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
  vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
  vim.api.nvim_set_keymap("i", "<C-E>", "<Plug>luasnip-next-choice", {})
  vim.api.nvim_set_keymap("s", "<C-E>", "<Plug>luasnip-next-choice", {})
end
