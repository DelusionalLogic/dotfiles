#!/bin/bash
echo -n "%{T$icon}"
if [ "$status" == "Charging" ] || [ "$status" == "Full" ]; then
	echo -en "%{B$charging_col} \uE239"
elif [[ $percentage > 50 ]]; then
	echo -en "%{B$high_col} \uE238"
elif [ "$status" == "Discharging" ] && [[ $percentage > 10 ]]; then
	echo -en "%{B$mid_col} \uE237"
else
	echo -en "%{B$low_col} \uE236"
fi
echo "%{F-}%{T-} $percentage "
