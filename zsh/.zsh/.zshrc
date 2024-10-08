#!/bin/zsh

echo ".zshrc"

export EDITOR="nvim"
export GIT_EDITOR="nvim"
export SUDO_EDITOR="nvim"
export XDG_CONFIG_HOME="$HOME/.config"
export MANPAGER="nvim +Man!"

### Imports
source ${ZDOTDIR}/utils.zsh
# source ${ZDOTDIR}/plugins.zsh
source ${ZDOTDIR}/zap.zsh
source ${ZDOTDIR}/settings.zsh
source ${ZDOTDIR}/aliases.zsh

PATH=$PATH:$HOME/.local/bin:$HOME/bin

if [ -f ~/.zshrc_local ]; then
    source ~/.zshrc_local
fi

export FZF_DEFAULT_COMMAND='rg --files --follow --hidden -g "!node_modules" -g "!.git"'

if has thefuck; then
    eval "$(thefuck --alias)"
fi

# fnm
if has fnm; then
    eval "$(fnm env --use-on-cd --shell zsh)"
fi

if has starship; then
    eval "$(starship init zsh)"
else
    echo "🚀 Starship command not found."
fi

if has fzf; then
    source <(fzf --zsh)
fi

if has zoxide; then
    eval "$(zoxide init zsh)"
fi
