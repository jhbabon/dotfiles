return function()
  -- NOTE: If some parsers fail to install, try to install tree-sitter-cli with npm:
  --   npm install -g tree-sitter-cli

  -- require("nvim-treesitter.install").prefer_git = true
  require("nvim-treesitter.configs").setup({
    -- list from: https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
    ensure_installed = {
      "bash",
      "c",
      "c_sharp",
      "clojure",
      "cmake",
      "comment",
      "commonlisp",
      "cpp",
      "css",
      "dockerfile",
      "eex",
      "elixir",
      "erlang",
      "fennel",
      "fish",
      "glimmer",
      "go",
      "gomod",
      "gowork",
      "graphql",
      "help",
      "hjson",
      "html",
      "http",
      "java",
      "javascript",
      "jsdoc",
      "json",
      "json5",
      "jsonc",
      "julia",
      "kotlin",
      "latex",
      "llvm",
      "lua",
      "make",
      "markdown",
      "nix",
      "pascal",
      "perl",
      "php",
      -- "phpdoc",
      "prisma",
      "python",
      "query",
      "r",
      "regex",
      "ruby",
      "rust",
      "scala",
      "scheme",
      "scss",
      "svelte",
      -- "todotxt",
      "toml",
      "tsx",
      "typescript",
      "vala",
      "vim",
      "vue",
      "yaml",
      "zig",
    },
    sync_install = false,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
      enable = true,
    },
    indent = {
      enable = true,
    },
    matchup = {
      enable = true,
    },
  })

  -- Use treesitter's folding module
  vim.opt.foldlevel = 5
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
end
