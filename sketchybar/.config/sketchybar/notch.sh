#!/bin/sh

export HAS_NOTCH=false

MODEL="$(system_profiler SPHardwareDataType | grep 'Model Identifier' | awk '{print $3}')"

if [ "$MODEL" = 'MacBookAir10,1' ]; then
    return
else
    # This is used to determine if a monitor is used
    # Since the notch is -only- on the laptop, if a monitor isn't used,
    # then that means the internal display is used ¯\_(ツ)_/¯
    MAIN_DISPLAY=$(system_profiler SPDisplaysDataType | grep -B 3 'Main Display:' | awk '/Display Type/ {print $3}')
    [ "$MAIN_DISPLAY" = 'Built-in' ] && HAS_NOTCH=true
fi

