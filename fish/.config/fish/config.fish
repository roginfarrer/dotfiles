if test -d ~/.bun/bin
    fish_add_path ~/.bun/bin
end
if test -d ~/.local/share/bob/nvim-bin
    fish_add_path ~/.local/share/bob/nvim-bin
end
if test -d ~/.cargo/bin
    fish_add_path ~/.cargo/bin
end
if test -d /opt/homebrew/bin
    fish_add_path /opt/homebrew/bin
end
# Install Fisher if it's not installed
if not functions -q fisher && status is-interactive
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
end

# Global variables to store cache
set -g __FUNCTION_CACHE_RESULT ""
set -g __FUNCTION_CACHE_TIMESTAMP 0
set -g __FUNCTION_CACHE_COMMIT_HASH ""

set -g fish_greeting

set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx SUDO_EDITOR $EDITOR
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -x MANPAGER "nvim +Man!"

if command -q zoxide
    zoxide init fish | source
end

abbr g git
abbr gs "git status"
# abbr gd "nvim -c DiffviewOpen"
abbr lg lazygit
abbr commit "git commit"
abbr branch "git for-each-ref --sort=committerdate refs/heads --color --format='%(HEAD)%(color:bold green)%(committerdate:short)|%(color:yellow)%(refname:short)%(color:reset)'|column -ts'|'"
abbr staged "git diff --staged"
abbr amend "git commit --amend --no-edit"
abbr unamend "git reset --soft HEAD@{1}"
abbr co "git checkout"
abbr gc "git add -A && git commit -m"
abbr mom "git checkout main && git pull && git checkout - && git merge main"
abbr pull "git pull"
abbr push "git push"
abbr mpull "git checkout main && git pull"
abbr add "git add -A"
abbr fetch "git fetch"
abbr uncommit "git reset --soft HEAD~1"
abbr unstage "git reset HEAD"
abbr discard "git clean -df && git checkout -- ."
abbr merge "git merge"
abbr squash "git merge --squash"
abbr gitlog "git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit" # prettifies the log
abbr gcp "git cherry-pick"
abbr sshpi "ssh -t pi@192.168.0.194 'export TERM=linux; fish'"
abbr themes "kitty +kitten themes"
abbr p pnpm
abbr b bun
abbr mycommits 'git log --author="Rogin Farrer <rogin@roginfarrer.com>" --oneline'
abbr rpull 'git pull --rebase origin main'

if test -e $HOME/.config/fish/local-config.fish
    source $HOME/.config/fish/local-config.fish
end

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

fish_vi_key_bindings
set fish_vi_force_cursor 1
# Emulates vim's cursor shape behavior
# Set the normal and visual mode cursors to a block
set fish_cursor_default block
# Set the insert mode cursor to a line
set fish_cursor_insert line
# Set the replace mode cursor to an underscore
set fish_cursor_replace_one underscore
# The following variable can be used to configure cursor shape in
# visual mode, but due to fish_cursor_default, is redundant here
set fish_cursor_visual block

# The next line updates PATH for the Google Cloud SDK.
# if test -e /Users/rfarrer/google-cloud-sdk/path.fish.inc
#     . '/Users/rfarrer/google-cloud-sdk/path.fish.inc'
# end

if test -d $HOME/.tmux/plugins/t-smart-tmux-session-manager/bin
    fish_add_path $HOME/.tmux/plugins/t-smart-tmux-session-manager/bin
end
if test -d $HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin
    fish_add_path $HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin
end

if command -q fish_ssh_agent
    fish_ssh_agent
end
