function has() {
    if command -v "$1" >/dev/null 2>&1; then
        return 0  # true
    else
        return 1  # false
    fi
}

ll() {
    if has lsd; then
        lsd -1h "$@"
    else
        ls -1h "$@"
    fi
}

ls() {
    if command -v lsd >/dev/null 2>&1; then
        lsd --group-dirs first "$@"
    else
        ls "$@"
    fi
}

mux() {
    if ! tmux list-sessions &>/dev/null; then
        tmux new -s dotfiles -c "$HOME/dotfiles" "$@"
    else
        if (( $# )); then
            tmux "$@"
        else
            tmux attach
        fi
    fi
}

brew-upgrade() {
    # Fetch updates first so progress messages don’t disrupt fzf
    brew outdated >/dev/null

    brew outdated |
        fzf -m --header='Tab to select, Enter to upgrade' |
        xargs brew upgrade
}

snag() {
    # Choose the source branch
    local branch
    branch=$(git for-each-ref --format='%(refname:short)' refs/heads |
        fzf --height 20% --layout=reverse --border)

    [[ -z "$branch" ]] && return

    # Choose differing files
    local -a files
    files=("${(@f)$(git diff --name-only "$branch" |
        fzf --height 20% --layout=reverse --border --multi)}")

    [[ ${#files[@]} -eq 0 ]] && return

    git checkout "$branch" -- "${files[@]}"
}

tree() {
    if command -v lsd >/dev/null 2>&1; then
        lsd --tree --group-dirs first --depth=2 "$@" 2>/dev/null
        return
    fi

    command tree "$@"
}
