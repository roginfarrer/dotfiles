function fco -d "Use `fzf` to choose which branch to check out" --argument-names branch
    set -q branch[1]; or set branch ''
    set selected (git for-each-ref --sort=-committerdate refs/heads --format='%(refname:short)' | fzf --height 10% --layout=reverse --border --query=$branch --select-1)
    test -n "$selected"; and git checkout $selected
end
