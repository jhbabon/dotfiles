# Basic config files

These are configuration files to set up a basic UNIX system with:

* vim
* tmux
* zsh
* rbenv
* git

## Usage

Basic installation:

```sh
$ git clone git://github.com/jhbabon/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ rake install
```

You can remove it and restore the previous files:

```sh
$ rake remove
```

Finally, you can update the git submodules easily:

```sh
$ rake bundles:update
```

## Attributions

All the configuration files are based on the following works:

* ryanb / dotfiles: https://github.com/ryanb/dotfiles
* cloudhead / dotfiles: https://github.com/cloudhead/dotfiles
* robbyrussell / oh-my-zsh: https://github.com/robbyrussell/oh-my-zsh
* sjl / dotfiles: https://github.com/sjl/dotfiles
