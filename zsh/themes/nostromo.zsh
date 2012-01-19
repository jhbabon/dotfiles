# nostromos theme

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

  local git_info=""
  git_info+="%{$fg[cyan]%}$(zgit_branch)%{$reset_color%}"
  git_info+="(%{$fg[yellow]%}$(git_sha)%{$reset_color%}) | "

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

bundler_label() {
  $($(which _bundled > /dev/null 2>&1) && _bundled) || return
  local bundler_prompt
  bundler_prompt="%{$fg[blue]%}b!%{$reset_color%} "

  echo "$bundler_prompt"
}

function nostromo() {
  local nostromo_prompt=''
  nostromo_prompt+="%{$fg[white]%}%2~ %{$reset_color%}"
  nostromo_prompt+="$(bundler_label)"
  nostromo_prompt+="$(git_dirty)"
  nostromo_prompt+="%{$fg[white]%}%# %{$reset_color%}"


  echo "$nostromo_prompt"
}

function nostromo_right() {
  local nostromo_rprompt
  nostromo_rprompt=''
  nostromo_rprompt+="$(git_status)"
  nostromo_rprompt+="%{$fg[green]%}%m%{$reset_color%}"

  echo "$nostromo_rprompt"
}

PROMPT='$(nostromo)'
RPROMPT='$(nostromo_right)'

# vim:set ft=zsh:
