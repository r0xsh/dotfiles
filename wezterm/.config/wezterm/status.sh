#!/bin/env sh

printf "󰚔 %s  %s" $(lspmux status | grep 'pid' | wc -l) $(date +%R)
