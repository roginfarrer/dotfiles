function yw
    set tmpDir (string join '' "$TMPDIR" "yarn-workspace")
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
            set list (yarn workspaces list --json | jq '.name' -r)
        end
        set list (string join "\n" $list)
        echo -e $list >>$cache
    end

    set workspace (echo -e $list | fzf)
    if not string length -q "$workspace"
        return
    end
    if string length -q "$argv"
        commandline "yarn workspace $workspace $argv"
        # yarn workspace $workspace $argv
    else
        commandline "yarn workspace $workspace "
    end
    # set_color --dim
    # echo "yarn workspace $workspace $argv"
    # set_color normal
end
