#!/bin/sh

# This is used to determine if a monitor is used
# Since the notch is -only- on the laptop, if a monitor isn't used,
# then that means the internal display is used ¯\_(ツ)_/¯
MAIN_DISPLAY=$(system_profiler SPDisplaysDataType | grep -B 3 'Main Display:' | awk '/Display Type/ {print $3}')
HAS_NOTCH=false
[ $MAIN_DISPLAY = 'Built-in' ] && HAS_NOTCH=true

sketchybar --set notch_spacer drawing=!$HAS_NOTCH
