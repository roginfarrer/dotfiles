(( $+commands[fnm] )) || return 1
eval "$(fnm env --use-on-cd --shell zsh)"
