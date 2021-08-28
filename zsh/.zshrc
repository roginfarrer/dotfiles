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

# export PATH="/Users/rfarrer/.nvm/versions/node/v8.9.4/bin:/Users/rfarrer/.local/bin:”/Users/rfarrer/platform-tools/bin:/usr/local/opt/php@7.2/sbin:/usr/local/opt/php@7.2/bin:/Users/rfarrer/.composer/vendor/bin:/Users/rfarrer/Wayfair/wf:/Users/rfarrer/.rbenv/bin:/usr/local/share/npm/bin:/usr/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/rfarrer/bin:/usr/local/bin”:/Users/rfarrer/bin:/usr/local/opt/fzf/bin:/Users/rfarrer/.vimpkg/bin"

eval $(thefuck --alias)
# fnm
eval "$(fnm env --multi)"


export NNN_PLUG='f:fzcd;o:fzopen;'
