#!/bin/sh

FONT="FiraCodeNerdFontMono"
TEXT="#cdd6f4"

DND=$(dunstctl is-paused)
polybar-msg cmd hide
dunstctl set-paused true

i3lock --force-clock --nofork --fill --bar-indicator --bar-orientation=vertical \
    --time-str="%H:%M" --date-str="%a %d %b" \
    --time-font=$FONT --time-size=46 \
    --date-font=$FONT --date-size=22 \
    --time-color=$TEXT --date-color=$TEXT \
    --verif-text="" --wrong-text="" --noinput-text="" \
    --lock-text="" --lockfailed-text="" \
    --bar-color="#1e1e2e99" --ringver-color="#b4befe99" \
    --ringwrong-color="#f38ba899" --keyhl-color="#a6e3a199" --bshl-color="#f38ba899" \
    --bar-step=10 --bar-base-width=7 --bar-max-height=7 \
    --image=$HOME/.config/i3/lock.png

if [ $DND == "false" ]; then
    dunstctl set-paused false
fi
polybar-msg cmd show
