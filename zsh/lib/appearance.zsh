# appearance

# ls colors
autoload colors; colors;
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# prompt
autoload -U promptinit
promptinit
setopt prompt_subst                          # expand functions in the prompt
export PS1='[%m: %1~]%# '                    # default prompt style

# use the default theme
if [[ -s $ZSH/themes/default.zsh ]] ; then source $ZSH/themes/default.zsh ; fi

# vim:set ft=zsh:
