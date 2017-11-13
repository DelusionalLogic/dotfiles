if [[ -z $essid ]]; then
	essid="Not connected"
fi

echo -n "%{T$icon}"
if [[ quality -gt 60 ]]; then
	echo -en "%{B$good_col} \uE222 "
elif [[ quality -gt 40 ]]; then
	echo -en "%{B$mid_col} \uE221 "
elif [[ quality -gt 20 ]]; then
	echo -en "%{B$low_col} \uE220 "
else
	echo -en "%{B$low_col} \uE21F "
fi
echo "%{T-}%{F-}$essid "
