#! /bin/zsh
# main zshrc file
# based on:
#   @link: http://github.com/jferris/config_files/blob/master/zshrc
#   @link: http://github.com/robbyrussell/oh-my-zsh

# path to the zshrc configuration files
export ZSH=$HOME/.zsh

# add a function path
fpath=($ZSH/bundle/**/functions $fpath)
typeset -U fpath

# load all of the config files
for config_file ($ZSH/lib/*.zsh) source $config_file
unset config_file

# vim:set ft=zsh:
