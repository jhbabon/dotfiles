return function()
  local null_ls = require("null-ls")

  local sources = {
    -- javascript & typescript
    null_ls.builtins.formatting.eslint,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.code_actions.eslint,

    -- golang
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.goimports,

    -- lua
    null_ls.builtins.formatting.stylua,

    -- git
    null_ls.builtins.code_actions.gitsigns,
  }

  null_ls.setup({
    sources = sources,
  })
end
