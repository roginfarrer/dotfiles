function brew-upgrade -d "Use `fzf` to interactively select and upgrade homebrew pkgs"
    brew outdated | fzf -m --header='Tab to select, Enter to upgrade' | xargs brew upgrade
end
