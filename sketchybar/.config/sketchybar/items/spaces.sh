#!/bin/bash

source "$XDG_CONFIG_HOME/sketchybar/icons.sh"

sid=0
declare -a spacesArray=()
for sid in {1..10}
do

    space=(
        associated_space=$sid
        script="$PLUGIN_DIR/spaces.sh"
        label.drawing=off
        icon.padding_left=6
        icon.padding_right=6
        padding_left=4
        padding_right=4
        update_freq=1
    )

    spacesArray+=("space.$sid")

    sketchybar --add space space.$sid left \
        --set space.$sid "${space[@]}" \
        --subscribe space.$sid mouse.clicked
done
