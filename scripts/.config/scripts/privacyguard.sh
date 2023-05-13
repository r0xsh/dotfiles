#!/bin/sh

STATE=$(awk 'NR==1{print $2}' /proc/acpi/ibm/lcdshadow)
if [ $STATE == "1" ]; then
	echo ""
else
	echo ""
fi
