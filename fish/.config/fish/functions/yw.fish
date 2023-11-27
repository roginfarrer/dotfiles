function yw
    if not type -q jq
        echo "$(set_color yellow)yw$(set_color normal) requires the 'jq' command. Please install jq then try again."
        return 1
    end

    set tmpDir (string join '' "$TMPDIR" "yarn-workspace")

    if test "$argv" = --clear-cache
        rm -r $tmpDir
        echo "Cache deleted."
        return
    end

    if not test -d $tmpDir
        mkdir $tmpDir
    end

    set dirName (basename $PWD)

    set cache "$tmpDir/$dirName.txt"

    if test -e $cache
        set workspaces (cat $cache)
    else
        set isYarnV1 (yarn --version | string match '1**')
        if string length -q "$isYarnV1"
            # jq command turns the Yarn Classic format to match Berry's
            set workspaces (yarn workspaces --silent info --json | jq -r "to_entries[] | {name: .key, location: .value.location} | tostring")
        else
            set workspaces (yarn workspaces list --json)
        end
        printf '%s\n' $workspaces >>$cache
    end
    set list (echo -e $workspaces | jq '.name' -r)

    set workspace (printf '%s\n' $list | fzf)
    if not string length -q "$workspace"
        return
    end

    set manifest "$(printf '%s\n' $workspaces | rg \"$workspace\" | jq '.location' | sed 's/"//g')/package.json"
    set cmd (jq -r '.scripts | keys | .[]' $manifest | fzf)

    if not string length -q "$cmd"
        commandline "yarn workspace $workspace "
        return
    end

    commandline "yarn workspace $workspace $cmd"
    commandline -f execute
end
