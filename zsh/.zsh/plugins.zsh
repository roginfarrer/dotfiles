ANTIDOTE_PATH="${ZDOTDIR:-~}/.antidote"

if ! [[ -d $ANTIDOTE_PATH ]]; then
    git clone --depth=1 https://github.com/mattmc3/antidote.git "$ANTIDOTE_PATH"
fi

source $ANTIDOTE_PATH/antidote.zsh
antidote load

antidote bundle <$ZDOTDIR/.zsh_plugins.txt >$ZDOTDIR/.zsh_plugins.zsh
source $ZDOTDIR/.zsh_plugins.zsh
