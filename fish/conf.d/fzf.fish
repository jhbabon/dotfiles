if test (which rg ^ /dev/null);
  # ripgrep configuration:
  #
  # --files: List files that would be searched but do not search
  # --hidden: Search hidden files and folders
  # --follow: Follow symlinks
  # --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
  #
  # optional configuration:
  # --no-ignore: Do not respect .gitignore, etc...

  export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
end
