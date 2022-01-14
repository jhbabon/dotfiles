return function()
  local cmp = require("cmp")
  local lspkind = require("lspkind")
  local luasnip = require("luasnip")

  -- This should load vscode snippets from friendly snippets
  require("luasnip.loaders.from_vscode").lazy_load()

  local function has_words_before()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  cmp.setup({
    completion = {
      autocomplete = false,
    },
    formatting = {
      format = lspkind.cmp_format({
        with_text = true,
        menu = {
          buffer = "[buffer]",
          nvim_lsp = "[lsp]",
          luasnip = "[snip]",
        },
      }),
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
    mapping = {
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<C-e>"] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "luasnip" },
    }, {
      { name = "buffer", keyword_length = 3 },
    }),
  })

  -- Save cmp in the global object
  _G.vimrc = _G.vimrc or {}
  function _G.vimrc.cmp()
    cmp.complete()
  end

  -- Override <c-x><c-o> to use cmp as the default omnifunc
  vim.cmd([[inoremap <c-x><c-o> <cmd>lua vimrc.cmp()<cr>]])
end
