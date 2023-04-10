# Install Fisher if it's not installed
if not functions -q fisher && status is-interactive
    curl -sL https://git.io/fisher | source && fisher update || fisher install jorgebucaran/fisher
end

# alias nvim 'nvim --startuptime /tmp/nvim-startuptime'
# if test -n "$NVIM_LISTEN_ADDRESS"
#     alias nvim "nvr -cc split --remote-wait +'set bufhidden=wipe'"
# end
# if test -n "$NVIM_LISTEN_ADDRESS"
#     set -gx VISUAL "nvr -cc split --remote-wait +'set bufhidden=wipe'"
#     set -gx EDITOR "nvr -cc split --remote-wait +'set bufhidden=wipe'"
# else
set -gx EDITOR nvim
set -gx VISUAL nvim
# end

set -gx SUDO_EDITOR $EDITOR
set -gx MANPAGER "nvim +Man!"

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

# Bun
set -px --path PATH "/Users/rfarrer/.bun/bin"

# fish_add_path /Users/rfarrer/.spicetify
source $HOME/.config/fish/themes/rose-pine.fish
