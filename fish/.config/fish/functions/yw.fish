function yw
    set tmpDir (string join '' "$TMPDIR" "yarn-workspace")

    if test "$argv" = --clear-cache
        rm -r $tmpDir
        echo "Cache deleted."
        return 1
    end

    if not test -d $tmpDir
        mkdir $tmpDir
    end

    set dirName (basename $PWD)

    set cache "$tmpDir/$dirName.txt"

    if test -e $cache
        set list (bat $cache | string join "\n")
    else
        set isYarnV1 (yarn --version | string match '1**')
        if string length -q "$isYarnV1"
            set list (yarn workspaces --silent info --json | jq -r '[keys][0] []')
        else
            set workspaces (yarn workspaces list --json)
            set list (jq '.name' -r workspaces)
        end
        set list (string join "\n" $list)
        echo -e $list >>$cache
    end

    set workspace (echo -e $list | fzf)
    if not string length -q "$workspace"
        return
    end
    function stripQuotes
        sed 's/"//g' $argv
    end
    set manifest "$(printf '%s\n' $workspaces | rg \"$workspace\" | jq '.location' | stripQuotes)/package.json"
    set cmd (jq -r '.scripts | keys | .[]' $manifest | fzf)
    if not string length -q "$cmd"
        commandline "yarn workspace $workspace "
        return
    end

    commandline "yarn workspace $workspace $cmd"
    commandline -f execute
    # if string length -q "$argv"
    #     commandline "yarn workspace $workspace $argv"
    #     # yarn workspace $workspace $argv
    # else
    #     commandline "yarn workspace $workspace "
    # end
    # set_color --dim
    # echo "yarn workspace $workspace $argv"
    # set_color normal
end
