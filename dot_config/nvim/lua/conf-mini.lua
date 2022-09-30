-- Mini plugins
-- @see https://github.com/echasnovski/mini.nvim
return function()
  -- Show indent lines
  require("mini.indentscope").setup({
    symbol = [[·]], -- Middle Dot (U+00B7)
  })

  -- Per line commenting. Replacement of tpope/vim-commentary
  require("mini.comment").setup({})

  -- Automatic highlighting of word under cursor
  require("mini.cursorword").setup({})

  -- Minimal and fast module for smarter jumping to a single character
  require("mini.jump").setup({})

  -- Minimal and fast Lua plugin for jumping (moving cursor)
  -- within visible lines via iterative label filtering
  require("mini.jump2d").setup({})

  -- Autopair plugin
  -- Replaces windwp/nvim-autopairs
  require("mini.pairs").setup({})

  -- Session management
  require("mini.sessions").setup({
    -- local session file
    file = "Session.vim",
  })
  local function save()
    -- Save current session in local session file
    require("mini.sessions").write("Session.vim", {})
  end
  local function load()
    -- Load current session from local session file
    require("mini.sessions").read("Session.vim", {})
  end
  local keychain = require("keychain")
  keychain.set("n", "<leader>cs", save, { hint = { "checkpoint", "save current session" } })
  keychain.set("n", "<leader>cl", load, { hint = { "checkpoint", "load last session" } })

  -- Start screen
  local starter = require("mini.starter")
  starter.setup({
    items = {
      starter.sections.sessions(5, true),
      {
        {
          name = "Open file",
          action = [[lua require("scout.files").run()]],
          section = "Navigate",
        },
        {
          name = "Search word",
          action = [[Grepper -query<space>]],
          section = "Navigate",
        },
      },
      starter.sections.recent_files(5, false, false),
      starter.sections.builtin_actions(),
    },
  })

  -- Surround
  require("mini.surround").setup({})

  -- Statusline
  require("mini.statusline").setup({})
end
