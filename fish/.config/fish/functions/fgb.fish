function fgb
    git for-each-ref --sort=-committerdate refs/heads --format='%(refname:short)' | fzf
end
