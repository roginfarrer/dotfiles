# if test -z "$HERDR_TAB_ID"
#     exit
# end

# function _herdr_tab_preexec --on-event fish_preexec
#     set -l cmd (string split ' ' -- $argv[1])[1]
#     herdr tab rename $HERDR_TAB_ID (basename $cmd) 2>/dev/null
# end

# function _herdr_tab_postcmd --on-event fish_postexec
#     herdr tab rename $HERDR_TAB_ID (basename $PWD) 2>/dev/null
# end
for _f in $HOME/.config/herdr/plugins/github/herdr-automatic-rename-*/shell/hook.fish
    test -r "$_f"; and source "$_f"; and break
end
