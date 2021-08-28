source <(antibody init)

# Load antibody plugin manager
antibody bundle < ${PARTIALS}plugins.txt > ~/.zsh_plugins.sh

# Plugin Options
export NVM_LAZY_LOAD=true # Lazy load to improve perf
export NVM_AUTO_USE=true # use .nvmrc if it exists

# Plugins
antibody bundle zsh-users/zsh-completions
antibody bundle zsh-users/zsh-autosuggestions
antibody bundle eendroroy/zed-zsh
# these should be last!
antibody bundle zdharma/fast-syntax-highlighting
antibody bundle zsh-users/zsh-history-substring-search

# Keybindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# plugins=(vi-mode zsh-autosuggestions zsh-completions history-substring-search)

# Make it actually readable in terminals
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=3"
