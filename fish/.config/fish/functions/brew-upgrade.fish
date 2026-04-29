function brew-upgrade -d "Use `fzf` to interactively select and upgrade homebrew pkgs"
    # If not run in a while, it logs some fetching messages
    # So we run it first to get those out of the way
    brew outdated >/dev/null
    brew outdated | fzf -m --header='Tab to select, Enter to upgrade' | xargs brew upgrade
end
