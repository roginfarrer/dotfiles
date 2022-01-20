# Install Fisher if it's not installed
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# Initialize starship prompt
starship init fish | source

set USER rfarrer

alias nvim 'nvim --startuptime /tmp/nvim-startuptime'
if test -n "$NVIM_LISTEN_ADDRESS"
    alias nvim "nvr -cc split --remote-wait +'set bufhidden=wipe'"
end
if test -n "$NVIM_LISTEN_ADDRESS"
    set -gx VISUAL "nvr -cc split --remote-wait +'set bufhidden=wipe'"
    set -gx EDITOR "nvr -cc split --remote-wait +'set bufhidden=wipe'"
else
    set -gx EDITOR nvim
    set -gx VISUAL nvim
end

set -gx SUDO_EDITOR $EDITOR
set -gx MANPAGER "nvim +Man!"

abbr v nvim

### Git it!
abbr g git
abbr gs "git status"
abbr commit "git commit"
abbr mycommits "git log --author=$USER"
abbr branch "git for-each-ref --sort=committerdate refs/heads --color --format='%(HEAD)%(color:bold green)%(committerdate:short)|%(color:yellow)%(refname:short)%(color:reset)'|column -ts'|'"
abbr staged "git diff --staged"
abbr amend "git commit --amend --no-edit"
abbr unamend "git reset --soft HEAD@{1}"
abbr cb getBranch
# alias frem "git push -f ${cb}"
abbr co "git checkout"
abbr gc "git add -A && git commit -m"
abbr mom "git checkout main && git pull && git checkout - && git merge main"
abbr pull "git pull"
abbr push "git push"
abbr mpull "git checkout main && git pull"
abbr add "git add -A"
abbr fetch "git fetch"
abbr renameBranch "git branch -m"
abbr uncommit "git reset --soft HEAD~1"
abbr unstage "git reset HEAD"
abbr discard "git checkout -- ."
abbr delete_remote deleteRemoteBranch
abbr delete_local deleteBranch
abbr merge "git merge"
abbr squash "git merge --squash"
abbr gitlog "git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit" # prettifies the log
abbr gitlogchange "git log --oneline -p" # actual changes
abbr gitlogstat "git log --oneline --stat" # number of lines changed
abbr gitloggraph "git log --oneline --graph" # graph view of branches
abbr gcp "git cherry-pick"
abbr ls exa
abbr ll exa -1
abbr sshpi "ssh -t pi@192.168.0.194 'export TERM=linux; fish'"

alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

function fgb
    git for-each-ref --sort=-committerdate refs/heads --format='%(refname:short)' | fzf
end

alias fcb="fgb | xargs git checkout"

bind \cg\cb fgb

if test -e $HOME/.config/fish/local-config.fish
    source $HOME/.config/fish/local-config.fish
end

set -g FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git --exclude node_modules'
set -g FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -Ux ZK_NOTEBOOK_DIR $HOME/Dropbox\ \(Maestral\)/Obsidian
