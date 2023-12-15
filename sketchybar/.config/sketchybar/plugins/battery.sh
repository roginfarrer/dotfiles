#!/bin/sh

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

batt() {
    if [ $PERCENTAGE = "" ]; then
        exit 0
    fi

    case ${PERCENTAGE} in
        9[0-9] | 100)
            ICON="$BATTERY"
            ;;
        [6-8][0-9])
            ICON="$BATTERY_75"
            ;;
        [3-5][0-9])
            ICON="$BATTERY_50"
            ;;
        [1-2][0-9])
            ICON="$BATTERY_25"
            ;;
        *) ICON="$BATTERY_0" ;;
    esac

    if [[ $CHARGING != "" ]]; then
        ICON="$BATTERY_LOADING"
    fi

    sketchybar --set $NAME icon="$ICON"
}

if [ "$(pmset -g batt | grep "Battery")" != "" ]; then
    batt
else
    sketchybar --remove battery
    exit 0
fi
