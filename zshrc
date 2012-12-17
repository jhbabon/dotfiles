# main zshrc file
# based on:
#   @link: http://github.com/jferris/config_files/blob/master/zshrc
#   @link: http://github.com/robbyrussell/oh-my-zsh

export ZSHTHEME=nostromo

# load rc files
if [[ -n $ZSHDIR ]]; then
  # add a functions path
  fpath=($ZSHDIR/bundle/**/functions $fpath)

  # add completions
  fpath=($ZSHDIR/bundle/zsh-completions/src $fpath)

  typeset -U fpath

  # load rc libs
  loader "$ZSHDIR/lib/rc"
fi

# Trust the bin dir in safe git repositories
export PATH=".git/safe/../../bin:$PATH"

# vim:set ft=zsh:
