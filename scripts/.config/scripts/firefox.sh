#!/bin/sh

PROFILE=$($HOME/.config/scripts/firefox_profiles | rofi -dmenu -l 30 -p "Firefox")

if [ -z "$PROFILE" ]
then
  exit 1
fi

MANAGED_PROFILE=$PROFILE firefox-developer-edition -new-instance -P "$PROFILE"
