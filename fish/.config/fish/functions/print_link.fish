function print_link
    printf '\e]8;;%s\a%s\e]8;;\a' "$argv[1]" "$argv[2]"
end
