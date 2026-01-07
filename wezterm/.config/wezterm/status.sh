#!/bin/env sh

count=$(lspmux status | grep 'pid' | wc -l)
time=$(date +%R)

if [ "$count" -gt 0 ]; then
  printf "󰚔 %s  %s" "$count" "$time"
else
  printf "%s" "$time"
fi
