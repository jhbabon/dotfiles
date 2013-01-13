# Basic config files

These are configuration files to set up a basic UNIX system with:

* vim
* tmux
* zsh
* rbenv
* git

All the files are managed with the [stow](http://www.gnu.org/software/stow/ 'Stow program') program.

## Usage

Basic installation:

```sh
$ git clone git://github.com/jhbabon/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ scripts/check # verifies if the system has the needed packages
$ scripts/install-all
```

You can remove them:

```sh
$ scripts/remove-all
```

## Vim

My Vim configuration file uses [vundle](https://github.com/gmarik/vundle 'Vundle plugin') to manage the plugins. To install all the plugins, run the following command:

```sh
$ vim -c BundleInstall
```

## Attributions

All the configuration files are based on the following works:

* ryanb / dotfiles: https://github.com/ryanb/dotfiles
* cloudhead / dotfiles: https://github.com/cloudhead/dotfiles
* robbyrussell / oh-my-zsh: https://github.com/robbyrussell/oh-my-zsh
* sjl / dotfiles: https://github.com/sjl/dotfiles
* topfunky / zsh-simple: https://github.com/topfunky/zsh-simple/
* Post in One Thing Well blog: http://onethingwell.org/post/39744163899
