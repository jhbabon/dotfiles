# Rake task autocompletion:
# @link: http://weblog.rubyonrails.org/2006/3/9/fast-rake-task-completion-for-zsh
# @link: http://www.noah.org/wiki/Test_file_age

_rake_does_task_list_need_generating() {
  if [ ! -f .rake_tasks ]; then return 0;
  else
    accurate=$(bc <<< '15*60') # regenerate every 15 minutes
    changed=$(($(date +%s) - $(stat -f%m .rake_tasks)))
    return $(expr $accurate '>=' $changed)
  fi
}

_rake() {
  if [ -f Rakefile ]; then
    if _rake_does_task_list_need_generating; then
      echo "\nGenerating .rake_tasks..." > /dev/stderr
      rake --silent --tasks | cut -d " " -f 2 > .rake_tasks
    fi
    compadd `cat .rake_tasks`
  fi
}

compdef _rake rake
