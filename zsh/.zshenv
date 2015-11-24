# .zshenv: sets the search path and env variables

# Mac OS X uses path_helper to preload PATH, clear it out first
# This file is executed in /etc/zprofile, which is loaded after
# zshenv if zsh is executed as a login shell. This means that
# the PATH will be redefined by /etc/zprofile. You should be aware
# of this problem.
if [ -x /usr/libexec/path_helper ]; then
  export PATH=''
  eval `/usr/libexec/path_helper -s`
fi

export EDITOR=vim
export PAGER=less
# export CLICOLOR="true"
# export LSCOLORS="Gxfxcxdxbxegedabagacad"
# export TERM=xterm-256color # set terminal colors

# Heroku Toolbelt
if [[ -d "/usr/local/heroku/bin" ]] ; then
  export PATH="/usr/local/heroku/bin:$PATH"
fi

# add texlive to PATH
if [[ -d "/usr/local/texlive/2012basic/bin/universal-darwin" ]]; then
  export PATH="/usr/local/texlive/2012basic/bin/universal-darwin:$PATH"
fi

# Postgres.app
if [[ -d "/Applications/Postgres.app" ]]; then
  export PATH="/Applications/Postgres.app/Contents/Versions/9.4/bin:$PATH"
fi

# rbenv
command -v rbenv > /dev/null && eval "$(rbenv init -)"

# direnv
command -v direnv > /dev/null && eval "$(direnv hook zsh)"

# golang
if [[ -d "$HOME/src/go" ]] ; then
  export GOPATH="$HOME/src/go"
  export PATH="$PATH:$GOPATH/bin"
fi

# zsh syntax highlighting
if [[ -d "/usr/local/share/zsh-syntax-highlighting" ]] ; then
  export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR="/usr/local/share/zsh-syntax-highlighting/highlighters"
fi

# Use NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Use extra .gemrc configuration
[[ -f "$HOME/.gemrc_local" ]] && export GEMRC="$HOME/.gemrc_local"

# load bin from safe dirs
export PATH=".safe/../bin:$HOME/.bin:$PATH"

# vim:set ft=zsh:
