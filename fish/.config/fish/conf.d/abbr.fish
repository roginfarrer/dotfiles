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
