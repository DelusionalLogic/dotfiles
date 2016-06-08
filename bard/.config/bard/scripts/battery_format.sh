
echo -n "%{T$icon}"
if [ "$status" == "Charging" ] || [ "$status" == "Full" ]; then
	echo -en "%{F$charging_col}\uE239"
elif [[ $percentage > 50 ]]; then
	echo -en "%{F$high_col}\uE238"
elif [ "$status" == "Discharging" ] && [[ $percentage > 10 ]]; then
	echo -en "%{F$mid_col}\uE237"
else
	echo -en "%{F$low_col}\uE236"
fi
echo " %{T-}%{F-}percentage"
