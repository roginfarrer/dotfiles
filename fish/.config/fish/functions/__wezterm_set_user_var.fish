# This function emits an OSC 1337 sequence to set a user var
# associated with the current terminal pane.
# It requires the `base64` utility to be available in the path.
# This function is included in the wezterm shell integration script, but
# is reproduced here for clarity
function __wezterm_set_user_var
    echo $argv[1] $argv[2]
    if set -q $TMUX
        # <https://github.com/tmux/tmux/wiki/FAQ#what-is-the-passthrough-escape-sequence-and-how-do-i-use-it>
        # Note that you ALSO need to add "set -g allow-passthrough on" to your tmux.conf
        printf "\033Ptmux;\033\033]1337;SetUserVar=%s=%s\007\033\\" $argv[1] `echo -n $argv[2] | base64`
    else
        printf "\033]1337;SetUserVar=%s=%s\007" $argv[1] (echo -n $argv[2] | base64)
    end
end
