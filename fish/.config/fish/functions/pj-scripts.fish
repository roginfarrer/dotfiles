function pj-scripts --argument file
    if not test -n "$file"
        set file 'package.json'
    end

    set scripts (jq '.scripts' $file | sed '1d;$d' | fzf --height 40%)
    if test -n $scripts
        set script_name (echo $scripts | awk -F ': ' '{gsub(/"/, "", $1); print $1}')
        echo "yarn run "(string trim $script_name)
        yarn run (string trim $script_name)
    else
        echo "Exit: You haven't selected any script"
    end
end
