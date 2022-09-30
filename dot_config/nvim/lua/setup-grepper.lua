return function()
  vim.g.grepper = {
    open = false, -- do not open the quickfix list
    switch = false, -- do not switch to the quickfix list
    tools = { "rg", "git", "grep" },
  }

  -- instead of the quickfix, use Trouble to see results
  vim.cmd([[autocmd User Grepper Trouble quickfix]])

  local keychain = require("keychain")

  keychain.set("n", "<leader>sw", [[:Grepper -noprompt -cword<cr>]], { hint = { "search", "current word" } })
  keychain.set("n", "<leader>sq", [[:GrepperRg<space>]], { silent = false, hint = { "search", "query" } })

  keychain.set(
    "n",
    "<leader>siw",
    [[:Grepper -tool git -noprompt -cword<cr>]],
    { hint = { "search", "current word with git" } }
  )
  keychain.set("n", "<leader>siq", [[:GrepperGit<space>]], { hint = { "search", "query with git" } })

  keychain.set(
    "n",
    "<leader>sgw",
    [[:Grepper -tool grep -noprompt -cword<cr>]],
    { hint = { "search", "current word with grep" } }
  )
  keychain.set("n", "<leader>sgq", [[:GrepperGrep<space>]], { hint = { "search", "query with grep" } })
end
