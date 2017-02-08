# Run ssh-agents with keychain
command -v keychain > /dev/null 2>&1 && eval "$(keychain --eval --noask --quiet ~/.ssh/id_rsa)"
