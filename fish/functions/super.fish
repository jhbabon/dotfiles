function super --description 'Run last command as sudo'
    eval "command sudo $history[1]"
end
