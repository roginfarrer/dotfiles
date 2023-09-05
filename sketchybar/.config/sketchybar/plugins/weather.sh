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
# TEMP=$(curl -s "https://wttr.in/$LOCATION_ESCAPED?format=1" | gsed 's/  */ /g' | gsed 's/+//g')
# echo $TEMP

LOC="$(echo $LOCATION_JSON | jq '.loc' | tr -d '"')"
LAT=$(echo "$LOC" | gsed "s/\(.*\),.*/\1/g")
LONG=$(echo "$LOC" | gsed "s/.*,\(.*\)/\1/g")
METEO=$(curl -s "https://api.open-meteo.com/v1/forecast?latitude=$LAT&longitude=$LONG&hourly=temperature_2m&current_weather=true&temperature_unit=fahrenheit" | jq '.current_weather.temperature' | xargs printf "%.0f\n")

sketchybar --set $NAME label="${METEO}°" click_script="/usr/bin/open /System/Applications/Weather.app"
