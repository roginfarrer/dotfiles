if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
fi

### Functions
# Quickly restart zsh
restartzsh () { echo "$fg_bold[yellow]Sourcing...$reset_color"; . ~/.zshrc; }

# Delete current branch
deleteBranch() {
  git branch -D $1;
  echo "$fg_bold[red]The local branch '$1' has been deleted.$reset_color";
}

# delete a remote branch
deleteRemoteBranch() {
  git push origin :$1;
  echo "$fg_bold[red]The remote branch '$1' has been deleted.$reset_color";
}

getBranch() {
  git branch --no-color | grep -E '^\*' | awk '{print $2}' \
    || echo "default_value"
  # or
  # git symbolic-ref --short -q HEAD || echo "default_value";
}

confirm() {
  read "response?Are you sure ? [Y/n] "
  response=${response:l} #tolower
  if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
    $1
  else
    echo 'Aborted!'
  fi
}

deleteOldBranchesLoop() {
  for k in $(git branch | sed /\*/d); do
    if [[ ! $(git log -1 --since='2 weeks ago' -s $k) ]]; then
      if [ -n "$1" ]
        then
          git branch -D $k
        else
          echo $k
      fi
    fi
  done
}

alias deleteOldBranches="confirm deleteOldBranchesLoop"

fgb() {
  git for-each-ref --sort=-committerdate refs/heads --format='%(refname:short)' | fzf
}

alias fcb="fgb | xargs git checkout"

## Config Files
alias dotfiles="${EDITOR} -n ~/dotfiles"
alias config="${EDITOR} -n ~/dotfiles/zsh"

### Git it!
alias g="git"
alias gs="git status"
alias commit="git commit"
alias mycommits="git log --author=${USER}"
alias branch="git for-each-ref --sort=committerdate refs/heads --color --format='%(HEAD)%(color:bold green)%(committerdate:short)|%(color:yellow)%(refname:short)%(color:reset)'|column -ts'|'"
alias staged="git diff --staged"
alias amend="git commit --amend --no-edit"
alias unamend="git reset --soft HEAD@{1}"
alias cb="getBranch"
alias frem="git push -f ${cb}"
alias co="git checkout"
alias gc="git add -A && git commit -m"
alias mom="git checkout master && git pull && git checkout - && git merge master"
alias pull="git pull"
alias push="git push"
alias mpull="git checkout master && git pull"
alias add="git add -A"
alias fetch="git fetch"
alias renameBranch="git branch -m"
alias uncommit="git reset --soft HEAD~1"
alias unstage="git reset HEAD"
alias discard="git checkout -- ."
alias delete_remote="deleteRemoteBranch"
alias delete_local="deleteBranch"
alias merge="git merge"
alias squash="git merge --squash"
alias gitlog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit" # prettifies the log
alias gitlogchange="git log --oneline -p" # actual changes
alias gitlogstat="git log --oneline --stat" # number of lines changed
alias gitloggraph="git log --oneline --graph" # graph view of branches
alias gcp="git cherry-pick"
alias config="git --git-dir=${HOME}/.dotfiles/ --work-tree=${HOME}"

### Misc
alias edit="${EDITOR}"

### Utilities
alias svg="svgo --config='${PARTIALS}/svgo_config.yml'"
