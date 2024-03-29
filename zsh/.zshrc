USER="rfarrer"

PARTIALS="/Users/${USER}/.zsh/"
EDITOR="nvim"
GIT_EDITOR="nvim"
WORKLOCATION="/Users/${USER}/Wayfair/"

export EDITOR="${EDITOR}"
export GIT_EDITOR="${GIT_EDITOR}"
export DEFAULT_USER="${USER}"

### Imports
# Order is important!
source ${PARTIALS}settings.zsh
source ${PARTIALS}plugins.zsh
source ${PARTIALS}aliases.zsh
source ${PARTIALS}spaceship.zsh

# https://stackoverflow.com/a/9810485
__git_files () {
    _wanted files expl 'local files' _files
}

if [ -f ~/.zshrc_local ]; then
  source ~/.zshrc_local
fi


export FZF_DEFAULT_COMMAND='rg --files --follow --hidden -g "!node_modules" -g "!.git"'

eval $(thefuck --alias)
# fnm
eval "$(fnm env)"

export NNN_PLUG='f:fzcd;o:fzopen;'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/vault vault
