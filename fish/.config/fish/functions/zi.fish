function zi --description "Like z, but choose with fzf"
    if test (count $argv) -ge 1
        set -g prev_z_argv $argv
    end
    if not set result (__z $prev_z_argv -l 2> /dev/null | fzf)
        return
    end
    cd (echo $result | sed -E 's/^[0-9.]+[ \t]+//')
end
