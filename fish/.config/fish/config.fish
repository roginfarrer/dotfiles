# Install Fisher if it's not installed
if not functions -q fisher && status is-interactive
    curl -sL https://git.io/fisher | source && fisher update || fisher install jorgebucaran/fisher
end

set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx SUDO_EDITOR $EDITOR
set -x MANPAGER "nvim +Man!"

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

if test -e $HOME/.config/fish/local-config.fish
    source $HOME/.config/fish/local-config.fish
end

set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git --exclude node_modules'
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -gx fzf_directory_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"
set -gx fzf_fd_opts --hidden --exclude=.git --exclude=node_modules
fzf_configure_bindings --directory=\cf

# bun
fish_add_path "$HOME/.bun/bin"

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true

# status is-interactive && oh-my-posh init fish --config $HOME/.config/oh-my-posh.json | source

fish_vi_key_bindings
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
