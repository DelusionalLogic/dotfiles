#!/bin/bash

mode=$1
unit=$2

if [ $mode == "enable" ]; then
		echo "Starting $unit"
		ln "modules/$unit" "./active_modules/$unit"
elif [ $mode == "disable" ]; then
		echo "Stopping $unit"
		rm "./active_modules/$unit"
elif [ $mode == "modules" ]; then
		echo "Possible modules"
		ls "./modules"
elif [ $mode == "enabled" ]; then
		echo "Enabled modules"
		ls "active_modules"
else
		echo "Should i enable or disable?"
		exit 1
fi
