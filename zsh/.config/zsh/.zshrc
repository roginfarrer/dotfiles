# zmodload zsh/zprof

export EDITOR="nvim"
export GIT_EDITOR="nvim"
export SUDO_EDITOR="nvim"

# Lazy-load (autoload) Zsh function files from a directory.
ZFUNCDIR=${ZDOTDIR:-$HOME}/functions
fpath=($ZFUNCDIR $fpath)
autoload -Uz $ZFUNCDIR/*(-.N:t)

# ---------- History ----------
HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=5000
SAVEHIST=5000

setopt APPEND_HISTORY
setopt SHARE_HISTORY        # share history between different instances
setopt HIST_IGNORE_ALL_DUPS # remove older duplicate entries from history
setopt HIST_REDUCE_BLANKS   # remove superfluous blanks from history items
setopt HIST_IGNORE_SPACE
setopt EXTENDED_HISTORY

# ---------- Shell ----------
setopt AUTO_CD              # cd by typing directory name if it's not a command
setopt AUTO_LIST            # automatically list choices on ambiguous completion
setopt AUTO_MENU            # automatically use menu completion
setopt ALWAYS_TO_END        # move cursor to end if word had one match
setopt INTERACTIVE_COMMENTS # allow comments in interactive shells
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

# Clone antidote if necessary.
if [[ ! -d ${ZDOTDIR:-$HOME}/.antidote ]]; then
    git clone https://github.com/mattmc3/antidote ${ZDOTDIR:-$HOME}/.antidote
fi

source ${ZDOTDIR:-$HOME}/.antidote/antidote.zsh
antidote load

# Source anything in .zshrc.d.
for _rc in ${ZDOTDIR:-$HOME}/.zshrc.d/*.zsh; do
    # Ignore tilde files.
    if [[ $_rc:t != '~'* ]]; then
        source "$_rc"
    fi
done
unset _rc

if [ -f "$HOME/.zshrc_local" ]; then
    source $HOME/.zshrc_local
fi
# zprof
