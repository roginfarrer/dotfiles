# https://github.com/kidonng/fisher_path.fish

set --query _fisher_path_initialized && exit
set --global _fisher_path_initialized

if test -z "$fisher_path"
    set fisher_path $XDG_CONFIG_HOME/.fisher
    echo "No \$fisher_path set. Set \$fisher_path to $fisher_path"
end

set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..]
set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..]

for file in $fisher_path/conf.d/*.fish
    if ! test -f (string replace --regex "^.*/" $__fish_config_dir/conf.d/ -- $file)
        and test -f $file && test -r $file
        source $file
    end
end
