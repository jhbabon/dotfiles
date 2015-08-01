# Basic config files

These are configuration files to set up a basic UNIX system with:

* vim
* tmux
* zsh
* git
* ctags
* homebrew
* ruby
* ag

All the files are managed with the [stow] program.

## Usage

Basic installation:

```sh
$ git clone git://github.com/jhbabon/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ scripts/check # verifies if the system has the needed packages
$ scripts/install # symlinks config files and setup Vim plugins.
```

You can remove them with:

```sh
$ scripts/remove
```

## Vim

The `.vimrc` file uses [vim-plug] to manage plugins.

## Attributions

All the configuration files are based on the following works:

* ryanb / dotfiles: https://github.com/ryanb/dotfiles
* cloudhead / dotfiles: https://github.com/cloudhead/dotfiles
* robbyrussell / oh-my-zsh: https://github.com/robbyrussell/oh-my-zsh
* sjl / dotfiles: https://github.com/sjl/dotfiles
* topfunky / zsh-simple: https://github.com/topfunky/zsh-simple/
* Post in One Thing Well blog: http://onethingwell.org/post/39744163899

[stow]: http://www.gnu.org/software/stow/
[vim-plug]: https://github.com/junegunn/vim-plug
