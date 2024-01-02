function mux -d "Start tmux with default directory and name" --argument-names tmux-arguments
    tmux list-sessions &>/dev/null
    if test $status -ne 0
        tmux new -s dotfiles -c ~/dotfiles $argv
    else
        set args attach
        if count $argv >/dev/null
            set args $argv
        end
        tmux $args
    end
end
