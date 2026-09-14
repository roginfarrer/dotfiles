#!/bin/zsh
ZDOTDIR=$HOME/.zsh
XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
SHELL="$(which zsh)"

if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi

if [ -f "/home/linuxbrew/.linuxbrew/bin" ]; then
    export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
fi

if [ -f "$HOME/.local/share/bob/nvim-bin" ]; then
    export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
fi
