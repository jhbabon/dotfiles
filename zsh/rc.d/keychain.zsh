# Run ssh-agents with keychain
 (( $+commands[keychain] )) && eval "$(keychain --eval --noask --quiet id_rsa)"
