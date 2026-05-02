function tree
    if command -q lsd
        lsd --tree --group-dirs first --depth=2 2>/dev/null $argv
        return
    end

    tree $argv
end
