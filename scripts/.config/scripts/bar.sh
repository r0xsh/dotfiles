#!/bin/bash

killall -q polybar
while pgrep -x polybar >/dev/null; do sleep 1; done

xrandr --listactivemonitors | tail -n +2 | while read -r line
do
  master=$(echo $line | grep '+\*')
  if [[ -z $master ]]
  then
    BAR="alt"
  else
    BAR="main"
  fi
  MONITOR=$(echo $line | awk '{print $4}') polybar $BAR &
done
