# tabtab source for packages
# uninstall by removing these lines
if status is-interactive
    [ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true
end
