#!/usr/bin/env sh

CACHE_FILE="/tmp/lspmux_count.cache"
CACHE_TTL=15

now_epoch=$(date +%s)
time=$(date +%R)
count=0

if [ -f "$CACHE_FILE" ]; then
  # Expect cache: "<epoch> <count>"
  read -r cache_epoch cache_count < "$CACHE_FILE" 2>/dev/null || cache_epoch=0

  if [ $((now_epoch - cache_epoch)) -lt "$CACHE_TTL" ] && [ -n "$cache_count" ]; then
    count=$cache_count
  fi
fi

if [ "$count" -eq 0 ]; then
  # recompute count (guard against lspmux failure)
  count=$(lspmux status 2>/dev/null | grep -c 'pid' || true)
  printf "%s %s\n" "$now_epoch" "$count" > "$CACHE_FILE"
fi

if [ "${count:-0}" -gt 0 ]; then
  printf "󰚔 %s  %s" "$count" "$time"
else
  printf "%s" "$time"
fi
