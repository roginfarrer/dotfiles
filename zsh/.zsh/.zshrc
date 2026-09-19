export EDITOR="nvim"
export GIT_EDITOR="nvim"
export SUDO_EDITOR="nvim"

# ---------- History ----------
HISTFILE="$HOME/.zsh_history"
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

function has() {
    if command -v "$1" >/dev/null 2>&1; then
        return 0  # true
    else
        return 1  # false
    fi
}

source $ZDOTDIR/functions.zsh
source $ZDOTDIR/themes/catppuccin.zsh

if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi

has fnm && eval "$(fnm env --use-on-cd --shell zsh)"
has zoxide && eval "$(zoxide init zsh)"
has starship && eval "$(starship init zsh)"

if has fzf; then
    export FZF_DEFAULT_OPTS="\
      --cycle --layout=reverse --border --height=90% --preview-window=wrap --marker=* \
      --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
      --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
      --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
    export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --hidden --exclude=.git --exclude=node_modules"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    source <(fzf --zsh)
fi

source /opt/homebrew/share/antidote/antidote.zsh
antidote load
