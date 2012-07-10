#!/usr/bin/env zsh

# git commands to use with the aliases

_git_ft() {
  local remote="origin";
  if [ $# -eq 1 ]; then
    remote=$1
  fi

  git fetch "$remote"
}

_git_ir() {
  local branch="master";
  if [ $# -eq 1 ]; then
    branch=$1
  fi

  _git_ft && git rebase -i origin/"$branch"
}

_git_up() {
  local branch="master";
  if [ $# -eq 1 ]; then
    branch=$1
  fi

  _git_ft && git rebase origin/"$branch"
}

_git_done() {
  local branch="master";
  if [ $# -eq 1 ]; then
    branch=$1
  fi

  git fetch && git rebase origin/"$branch" && git checkout "$branch" && git merge @{-1}
}

# vim:set ft=zsh:
