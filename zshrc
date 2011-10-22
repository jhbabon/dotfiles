# main zshrc file
# based on:
#   @link: http://github.com/jferris/config_files/blob/master/zshrc
#   @link: http://github.com/robbyrussell/oh-my-zsh

# load rc files
if [[ -n $ZSH ]]; then
  # add a functions path
  fpath=($ZSH/bundle/**/functions $fpath)
  typeset -U fpath

  # load rc libs
  loader "$ZSH/lib/rc"
fi

# vim:set ft=zsh:
