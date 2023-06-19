#!/bin/bash

if [ $1 == "toggle" ]; then
  dunstctl set-paused toggle &> /dev/null
  polybar-msg action dnd hook 0 &> /dev/null
fi

STATE=$(dunstctl is-paused)
if [ $STATE == "true" ]; then
  echo "%{F#f38ba8}%{F-}"
else
  echo "%{F#585b70}%{F-}"
fi
