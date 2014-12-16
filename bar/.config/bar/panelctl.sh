#!/bin/bash

if [ $1 == "enable" ]; then
		echo "Starting $2"
		ln "modules/$2" "./active_modules/$2"
elif [ $1 == "disable" ]; then
		echo "Stopping $2"
		rm "./active-modules/$2"
fi
