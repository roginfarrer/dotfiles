set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx SUDO_EDITOR $EDITOR
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -x MANPAGER "nvim +Man!"
