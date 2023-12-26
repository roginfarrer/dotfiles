#!/bin/bash

date=(
    update_freq=30
    script="$PLUGIN_DIR/date.sh"
    click_script="$POPUP_CLICK_SCRIPT"
    label.padding_left=5
    background.color=$TEMPUS
    background.height=$BG_HEIGHT
    background.padding_left=-5
)

sketchybar --add item date right \
    --set date "${date[@]}" \
    --subscribe date system_woke

