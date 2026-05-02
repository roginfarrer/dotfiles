function ls
    if command -q lsd
        lsd --group-dirs first $argv
        return
    end

    ls $argv
end
