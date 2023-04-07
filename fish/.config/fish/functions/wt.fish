# function work
#     begin
#         set -l IFS
#         set output (wt $argv)
#     end
#     switch $output
#         case "*-> *"
#             cd (echo $output | rg "\->" | sed "s/-> //g")
#     end
#     echo $output | rg -v "\->"
# end
function wt
    bass -d $HOME/dotfiles/fish/.config/fish/worktree $argv
end
