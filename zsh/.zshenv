# .zshenv: sets the search path and env variables

# clear PATH
export BACKUP_PATH=$PATH
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin"

export EDITOR=vim
export PAGER=/usr/bin/less
export CLICOLOR="true"
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export TERM=xterm-256color # set terminal colors

# Heroku Toolbelt
if [[ -d "/usr/local/heroku/bin" ]] ; then
  export PATH="/usr/local/heroku/bin:$PATH"
fi

# add texlive to PATH
if [[ -d "/usr/local/texlive/2011/bin/x86_64-darwin" ]]; then
  export PATH="/usr/local/texlive/2011/bin/x86_64-darwin:$PATH"
fi

# config rbenv:
if [[ -d "$HOME/.ruby-build" ]]; then
  export PATH="$HOME/.ruby-build/bin:$PATH"
fi
if [[ -d "$HOME/.rbenv" ]]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# load bin from safe dirs
export PATH=".safe/../bin:$HOME/.bin:$PATH"

# vim:set ft=zsh:
