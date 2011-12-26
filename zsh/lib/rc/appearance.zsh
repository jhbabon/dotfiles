# appearance

# ls colors
autoload colors; colors;
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# prompt
autoload -U promptinit
promptinit
setopt prompt_subst        # expand functions in the prompt
export PS1='[%m: %1~]%# '  # default prompt style

# use the default theme
if [[ -z $ZSHTHEME ]]; then
  export ZSHTHEME=default
fi

local theme=$ZSHDIR/themes/$ZSHTHEME.zsh
if [[ -s $theme ]] source $theme

# vim:set ft=zsh:
