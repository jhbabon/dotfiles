# From Arch Linux wiki:
# https://wiki.archlinux.org/index.php/Zsh#Dirstack

DIRSTACKFILE="$HOME/.cache/zsh/dirs"
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
fi

chpwd() {
  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}

DIRSTACKSIZE=20

setopt autopushd pushdsilent pushdtohome autocd

# Remove duplicate entries
setopt pushdignoredups

# This reverts the +/- operators.
setopt pushdminus
