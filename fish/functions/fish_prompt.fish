function fish_prompt --description "Write out the prompt"
  set -l last_status $status

  # Hack; fish_config only copies the fish_prompt function (see #736)
  if not set -q -g __fish_classic_git_functions_defined
    set -g __fish_classic_git_functions_defined

    function __fish_repaint_status --on-variable fish_color_status --description "Event handler; repaint when fish_color_status changes"
      if status --is-interactive
        commandline -f repaint ^/dev/null
      end
    end

    function __fish_repaint_bind_mode --on-variable fish_key_bindings --description "Event handler; repaint when fish_key_bindings changes"
      if status --is-interactive
        commandline -f repaint ^/dev/null
      end
    end

    # initialize global variables
    if not set -q __my_git_prompt_initialized
      set -qU fish_color_cwd; or set -U fish_color_cwd blue
      set -qU fish_color_status; or set -U fish_color_status red

      set -qU __fish_git_prompt_showdirtystate; or set -U __fish_git_prompt_showdirtystate "yes"
      set -qU __fish_git_prompt_showstashstate; or set -U __fish_git_prompt_showstashstate "yes"
      set -qU __fish_git_prompt_showuntrackedfiles; or set -U __fish_git_prompt_showuntrackedfiles "yes"
      set -qU __fish_git_prompt_showupstream; or set -U __fish_git_prompt_showupstream "auto informative name git"
      set -qU __fish_git_prompt_showcolorhints; or set -U __fish_git_prompt_showcolorhints "yes"
      set -qU __fish_git_prompt_show_informative_status; or set -U __fish_git_prompt_show_informative_status ""
      set -qU __fish_git_prompt_char_dirtystate; or set -U __fish_git_prompt_char_dirtystate "!"
      set -qU __fish_git_prompt_char_invalidstate; or set -U __fish_git_prompt_char_invalidstate "*"
      set -qU __fish_git_prompt_char_untrackedfiles; or set -U __fish_git_prompt_char_untrackedfiles "?"

      set -qU fish_color_status; or set -U fish_color_status red
      set -U fish_color_command green

      set -U __my_git_prompt_initialized
    end
  end

  set -l suffix
  set -l color_cwd
  set -l color_status (set_color $fish_color_status)
  set -l normal (set_color normal)
  set -l prompt_status
  set -l git_sha_color (set_color yellow)

  switch $USER
  case root toor
    if set -q fish_color_cwd_root
      set color_cwd (set_color $fish_color_cwd_root)
    end
    set suffix " # "
  case "*"
    set color_cwd (set_color $fish_color_cwd)
    set suffix " > "
  end

  if test $last_status -ne 0
    set prompt_status " " "$color_status" "($last_status)" "$normal"
  end

  set -l git_sha (command git rev-parse --short HEAD ^/dev/null)
  set -l git_format (printf " $color_cwd($normal%s %s$color_cwd)$normal" "$git_sha_color$git_sha$normal" "%s")

  echo -n -s $color_cwd (prompt_pwd) $normal (__fish_git_prompt $git_format) $normal $prompt_status $color_cwd $suffix $normal
end
