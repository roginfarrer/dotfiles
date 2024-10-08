[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

plug "jeffreytse/zsh-vi-mode"
plug "olets/zsh-abbr"
plug "hlissner/zsh-autopair"

# set up Zsh completions with plugins
plug "mattmc3/ez-compinit"
plug "zsh-users/zsh-completions"

# popular fish-like plugins
plug "mattmc3/zfunctions"
plug "zsh-users/zsh-autosuggestions"
plug "zdharma-continuum/fast-syntax-highlighting"
plug "zsh-users/zsh-history-substring-search"
