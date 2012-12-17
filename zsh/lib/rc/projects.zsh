# nav to projects source code

src() {
  if [ $# -eq 1 ]; then
    cd "$HOME/Code/projects/$1/src" 2>/dev/null ||
      cd "$HOME/Code/projects/$1"  2>/dev/null ||
      echo "---> no such file or directory: $HOME/Code/projects/$1{/src}"
  else
    echo "Nav to project's source code."
    echo "Each project should be under: $HOME/Code/projects"
    echo "Usage: src project_dir_name"
  fi
}

# vim:set ft=zsh:
