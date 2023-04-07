#!/usr/bin/env bash

IP=$(curl -s https://ipinfo.io/ip)
LOCATION_JSON=$(curl -s https://ipinfo.io/$IP/json)

# echo "$LOCATION_JSON"

LOCATION="$(echo $LOCATION_JSON | jq '.city' | tr -d '"')"
REGION="$(echo $LOCATION_JSON | jq '.region' | tr -d '"')"
COUNTRY="$(echo $LOCATION_JSON | jq '.country' | tr -d '"')"

# Line below replaces spaces with +
LOCATION_ESCAPED="${LOCATION// /+}+${REGION// /+}"

# The $NAME variable is passed from sketchybar and holds the name of
# the item invoking this script:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting
TEMP=$(curl -s "https://wttr.in/$LOCATION_ESCAPED?format=1" | gsed 's/  */ /g' | gsed 's/+//g')
# echo $TEMP

sketchybar --set $NAME label="${TEMP}" click_script="/usr/bin/open /System/Applications/Weather.app"
