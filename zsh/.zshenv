#!/bin/zsh
ZDOTDIR=$HOME/.zsh
XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
SHELL="$(which zsh)"

if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi
