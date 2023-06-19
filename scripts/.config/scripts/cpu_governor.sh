#!/bin/sh
GOVERNOR=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)

case $GOVERNOR in
  "powersave")
    echo -ne ""
    exit 0
    ;;
  "ondemand" | "schedutil")
    echo -ne ""
    exit 0
    ;;
  "performance")
    echo -ne ""
    exit 0
    ;;
esac
