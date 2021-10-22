# Install Fisher if it's not installed
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# Initialize starship prompt
starship init fish | source

# fnm
# fnm env --shell fish --use-on-cd | source
# fnm completions --shell fish | source

set USER rfarrer
set -Ux EDITOR nvim
set -Ux VISUAL nvim
set -Ux MANPAGER "nvim +Man!"

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

function check_nvm --description 'Change node version'
    # check if nvm is present
    if test -q $nvm
        # check if directory has a nvmrc
        if test -e $PWD/.nvmrc
            nvm use
            # or else a package.json
        else if test -e $PWD/package.json
            nvm use lts
        end
    end
end

function __check_nvm --on-variable PWD --description 'Change node version on cd'
    check_nvm
end

check_nvm

set -g FZF_CTRL_T_COMMAND 'rg --files'
# set -g fish_user_paths "/usr/local/opt/python@3.8/bin" $fish_user_paths

# source $XDG_CONFIG_HOME/fish/themes/tokyonight.fish
# source ~/.config/fish/themes/nordfox.fish
source $HOME/.config/fish/themes/nightfox.fish
