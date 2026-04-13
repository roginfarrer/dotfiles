set -gx FZF_DEFAULT_OPTS "\
  --cycle --layout=reverse --border --height=90% --preview-window=wrap --marker=* \
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
  --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
set -gx fzf_directory_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"
set -gx fzf_fd_opts --hidden --exclude=.git --exclude=node_modules
if type -q fzf_configure_bindings
    fzf_configure_bindings --directory=\cf
end
