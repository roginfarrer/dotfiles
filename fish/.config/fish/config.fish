# Install Fisher if it's not installed
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

if not test -d $XDG_CONFIG_HOME/nnn/plugins
    echo "Missing nnn plugins, installing..."
    curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs | sh
end

# Initialize starship prompt
starship init fish | source

# fnm
fnm env --shell fish --use-on-cd | source
fnm completions --shell fish | source

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

alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

function fgb
    git for-each-ref --sort=-committerdate refs/heads --format='%(refname:short)' | fzf
end

alias fcb="fgb | xargs git checkout"

bind \cg\cb fgb

if test -e ./local-config.fish
    source ./local-config.fish
end

set -g FZF_CTRL_T_COMMAND 'rg --files'
# set -g fish_user_paths "/usr/local/opt/python@3.8/bin" $fish_user_paths

# TokyoNight Color Palette
set -l foreground c0caf5
set -l selection 364A82
set -l comment 565f89
set -l red f7768e
set -l orange ff9e64
set -l yellow e0af68
set -l green 9ece6a
set -l purple 9d7cd8
set -l cyan 7dcfff
set -l pink bb9af7

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment
