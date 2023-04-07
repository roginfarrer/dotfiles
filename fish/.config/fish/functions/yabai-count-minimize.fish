set CURRENT_DISPLAY (yabai -m query --windows --window | jq '.display')
set WINDOWS_ARRAY (yabai -m query --windows --space $(yabai -m query --spaces --space | jq '.index') --display $CURRENT_DISPLAY | jq -r 'map(select(.["is-minimized"]==false and .["is-floating"]==false))')
set NUMBER_OF_WINDOWS (echo $WINDOWS_ARRAY | jq -r 'length')
set STACK (echo $WINDOWS_ARRAY | jq -re "sort_by(.frame.y) | .[2].id")
set LAST_MIN (yabai -m query --windows --space | jq -r '.[] | select(."is-minimized"==true).id' | tac | head -n 1)

switch $NUMBER_OF_WINDOWS
    case 0
        yabai -m config split_ratio 0.35
    case 1
        yabai -m config split_type auto
        yabai -m config split_ratio 0.5
    case 2
        yabai -m config split_ratio 0.5
        yabai -m config split_type horizontal
        yabai -m window $STACK --insert south
        yabai -m window --deminimize $LAST_MIN && sleep 0.2
        yabai -m window $STACK --insert south
        yabai -m window --focus north
        yabai -m window first --insert north
    case 3
        yabai -m window --warp first
        yabai -m window first --insert north
    case '*'
        yabai -m window uncle --minimize
        sleep 0.4
        yabai -m window --warp first
        yabai -m window first --insert north
end
