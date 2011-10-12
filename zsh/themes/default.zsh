# default theme
# based on the wunjo prompt theme:
#   @link: http://github.com/jcorbin/zsh-git/

# load dependencies
autoload -U zgitinit
zgitinit

git_sha() {
  zgit_isgit || return

  git describe --always $1 2>/dev/null ||
  git rev-parse --short $1 2>/dev/null
}

git_status() {
  zgit_isgit || return

  local git_info=" on "
  git_info+="%{$fg[cyan]%}$(zgit_branch)%{$reset_color%}"
  git_info+="(%{$fg[yellow]%}$(git_sha)%{$reset_color%})"

  echo "$git_info"
}

git_dirty() {
  zgit_isgit || return

  local -a output
  if zgit_inworktree; then
    if ! zgit_isindexclean; then
      output+="%{$fg[green]%}+%{$reset_color%}"
    fi

    if ! zgit_isworktreeclean; then
      output+="%{$fg[red]%}!%{$reset_color%}"
    fi

    if zgit_hasunmerged; then
      output+="%{$fg[red]%}*%{$reset_color%}"
    fi

    if zgit_hasuntracked; then
      output+="%{$fg[red]%}?%{$reset_color%}"
    fi

    if [ $#output -gt 0 ]; then
      echo -n "${(j::)output} "
    fi
  fi
}

function serenity() {
  local serenity_prompt
  serenity_prompt='\n'
  serenity_prompt+='%m: %2~'
  serenity_prompt+="$(git_status)"
  serenity_prompt+='\n'
  serenity_prompt+="$(git_dirty)"
  serenity_prompt+='%# '

  echo "$serenity_prompt"
}

PROMPT='$(serenity)'

# vim:set ft=zsh:
