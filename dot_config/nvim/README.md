## Neovim configuration

All the plugins that Neovim needs are installed through [chezmoi] as external files. They are defined in the main `.chezmoi.toml` file and their installation is defined in the `.chezmoiexternal.toml` file.

### Bug why?

I don't know, I guess I'm tired of switching package managers every X months. Also (Neo)vim already has a built in package manager system, it expects packages to be installed beforehand. That's the most common pattern in most programming languages and environments, think about `bundler` for `ruby` or `cargo` for `rust`.

I'm not going to build an external package manager for Neovim, but I can use [chezmoi] to do something similar. I have to deal with Go templates which is pretty close to my definition of hell along with YAML files, but it's for the greater good.

Another thing that (Neo)vim does pretty well is loading custom configurations by default thanks to the `plugin` directory. It's been there forever, and it works. All my configurations live there and it's nice.

### But what about bytecode and lua?

Since Neovim `0.9` there is a lua loader that does exactly that: [`vim.loader`][vim-loader].

### But what about lazy loading?

(Neo)vim has this amazing thing called events, and every plugin that lazy loads pretty much uses them. I don't need get too carried away thinking about lazy loading, I just need to make sure I put heavy things inside `VimEnter` or `UIEnter` events or even load things only when they are used. I think it's fine.

### But what about LSP configurations?

Since Neovim `0.11` LSP configurations can be defined inside `~/.config/nvim/lsp/<servername>.lua` and they also can be in `plugin` files, `init.lua` and local `.nvim.lua` files. This means a configuration can be changed as needed per project if needed. For more info check `:h lsp`.

To override a configuration in a project, it can be redefined inside a local `.nvim.lua` file. For example, to override `sorbet` in a ruby project:

```lua
-- .nvim.lua
-- Keep all sorbet options but change the main command
vim.lsp.config('sorbet', {
  cmd = { "bundle", "exec", "srb", "tc", "--lsp", "--disable-watchman" },
})
```

### Packages management

#### Adding new packages

After adding a new package to `.chezmoi.toml`, make sure [chezmoi] knows about it before applying the changes:

```sh
chezmoi init && chezmoi apply
```

#### Updating packages

The packages are configured to be refreshed after 72h, but it can be forced with the `-R` option:

```sh
chezmoi apply -R
```

#### Removing packages

Removing a package from the `.chezmoi.toml` file won't be enough as it will remain in the `pack` directory, but I added a "trick" to force [chezmoi] to remove it. If a package is present in the `data.nvim.graveyard` table, it will be added to `.chezmoiremove` and then removed by [chezmoi]. It's a bit cumbersome, but I'll live.

#### Removing plugin and other lua files

Chezmoi is not very good at removing things from the destination directory. The dotfiles for Neovim are all present inside the `dot_config` directory so the safest option to make sure an old plugin is not causing issues is to remove the destination directory and run `chezmoi apply` again.

```sh
rm -fr ~/.config/nvim
chezmoi init && chezmoi apply
```

[chezmoi]: https://www.chezmoi.io
[vim-loader]: https://neovim.io/doc/user/lua.html#vim.loader
