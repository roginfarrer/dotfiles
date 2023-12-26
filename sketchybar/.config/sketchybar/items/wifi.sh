#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

PLUGIN_DIR="$HOME/.config/sketchybar/plugins"
CURRENT_WIFI="$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I)"
SSID="$(echo "$CURRENT_WIFI" | grep -o "SSID: .*" | sed 's/^SSID: //')"
POPUP_OFF="sketchybar --set wifi.ssid popup.drawing=off && sketchybar --set wifi.speed popup.drawing=off"
WIFI_INTERFACE=$(networksetup -listallhardwareports | awk '/Wi-Fi/{getline; print $2}')
IP_ADDR=$(ipconfig getifaddr $WIFI_INTERFACE)

wifi=(
    script="$PLUGIN_DIR/wifi.sh"
    click_script="$POPUP_CLICK_SCRIPT"
    label.padding_right=4
    update_freq=60
    label=$WIFI
)

ssid=(
    icon=$NETWORK
    icon.padding_left=10
    label="$SSID"
    label.font="SF Pro:Bold:12.0"
    label.padding_left=10
    label.padding_right=10
    blur_radius=100
    update_freq=100
    click_script="open /System/Library/PreferencePanes/Network.prefPane/; $POPUP_OFF"
)

ip=(
    icon=$IP
    icon.padding_left=10
    label="$IP_ADDR"
    label.font="SF Pro:Bold:12.0"
    label.padding_left=10
    label.padding_right=10
    blur_radius=100
    click_script="open /System/Library/PreferencePanes/Network.prefPane/; $POPUP_OFF"
)

speed=(
    icon=$SPEED
    icon.padding_left=10
    label.font="SF Pro:Bold:12.0"
    label.padding_left=10
    label.padding_right=10
    blur_radius=100
    update_freq=10
    width=125
    script="$PLUGIN_DIR/speed.sh"
)

rm -f /tmp/sketchybar_speed
rm -f /tmp/sketchybar_wifi

sketchybar --add item wifi right \
    --set wifi "${wifi[@]}" \
    --subscribe wifi system_woke

sketchybar --add item wifi.ssid popup.wifi \
    --set wifi.ssid "${ssid[@]}"

sketchybar --add item wifi.ip popup.wifi \
    --set wifi.ip "${ip[@]}"

sketchybar --add item wifi.speed popup.wifi \
    --set wifi.speed "${speed[@]}"
