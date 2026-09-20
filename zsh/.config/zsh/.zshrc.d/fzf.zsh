(( $+commands[fzf] )) || return 1
export FZF_DEFAULT_OPTS="\
  --cycle --layout=reverse --border --height=90% --preview-window=wrap --marker=* \
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
  --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --hidden --exclude=.git --exclude=node_modules"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
source <(fzf --zsh)
