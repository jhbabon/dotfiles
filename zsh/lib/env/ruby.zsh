# Ruby version manager: rbenv or rvm, but not both

## rbenv: has preference over rvm
if [[ -s $HOME/.rbenv ]] ; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
## rvm
elif [[ -s $HOME/.rvm/bin ]] ; then
  export PATH=$HOME/.rvm/bin:$PATH
  source $HOME/.rvm/scripts/rvm
fi

# Rubinius options
export RBXOPT='-Xrbc.db'

# vim:set ft=zsh:
