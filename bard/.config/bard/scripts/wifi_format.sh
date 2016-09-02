if [[ -z $essid ]]; then
	essid="Not connected"
fi

echo -n "%{T$icon}"
if [[ quality -gt 60 ]]; then
	echo -en "%{F$good_col}\uE222"
elif [[ quality -gt 40 ]]; then
	echo -en "%{F$mid_col}\uE221"
elif [[ quality -gt 20 ]]; then
	echo -en "%{F$low_col}\uE220"
else
	echo -en "%{F$low_col}\uE21F"
fi
echo " %{T-}%{F-}$essid"
