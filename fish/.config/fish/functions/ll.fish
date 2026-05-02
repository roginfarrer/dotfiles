function ll
    if command -q lsd
        lsd -1h $argv
        return
    end

    ls -1h $argv
end
