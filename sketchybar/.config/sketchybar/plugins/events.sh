#!/bin/sh

NEXT_EVENT="$(shortcuts run 'Menubar Next Event' | bat)"

TIME="$(echo $NEXT_EVENT | cut -d ' ' -f1)"

NAME="$(echo $NEXT_EVENT | cut -d ' ' -f2-)"

sketchybar --set events label="${NAME:0:15} $TIME"
