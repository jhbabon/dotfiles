# add texlive to PATH

export MYTEXTLIVEDIR="/usr/local/texlive/2011/bin/x86_64-darwin"

if [[ -n $MYTEXTLIVEDIR ]]; then
  export PATH="$MYTEXTLIVEDIR:$PATH"
fi

# vim:set ft=zsh:
