#!/bin/zsh

echo "It's ZSH"

EDITOR="nvim"
GIT_EDITOR="nvim"

export EDITOR="${EDITOR}"
export GIT_EDITOR="${GIT_EDITOR}"
export DEFAULT_USER="${USER}"

### Imports
source ${ZDOTDIR}/utils.zsh
source ${ZDOTDIR}/plugins.zsh
source ${ZDOTDIR}/settings.zsh
source ${ZDOTDIR}/aliases.zsh

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
