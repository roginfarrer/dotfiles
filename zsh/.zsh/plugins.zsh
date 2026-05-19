ANTIDOTE_PATH="${ZDOTDIR:-~}/.antidote"

if ! [[ -d $ANTIDOTE_PATH ]]; then
    git clone --depth=1 https://github.com/mattmc3/antidote.git "$ANTIDOTE_PATH"
fi

source $ANTIDOTE_PATH/antidote.zsh

if [[ ! -f $ZDOTDIR/.zsh_plugins.zsh || $ZDOTDIR/.zsh_plugins.txt -nt $ZDOTDIR/.zsh_plugins.zsh ]]; then
    antidote bundle <$ZDOTDIR/.zsh_plugins.txt >$ZDOTDIR/.zsh_plugins.zsh
fi
source $ZDOTDIR/.zsh_plugins.zsh
