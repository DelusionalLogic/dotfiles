battery_status=$1
battery_percentage=$2

echo -n "%{T\$font[icon]}"
if [ "$battery_status" == "Charging" ] || [ "$battery_status" == "Full" ]; then
	echo -en "%{F\$xcolor[green]}\uE239"
elif [[ $battery_percentage > 50 ]]; then
	echo -en "%{F\$xcolor[green]}\uE238"
elif [ "$battery_status" == "Discharging" ] && [[ $battery_percentage > 10 ]]; then
	echo -en "%{F\$xcolor[yellow]}\uE237"
else
	echo -en "%{F\$xcolor[brightred]}\uE236"
fi
echo " %{T-}%{F-}$battery_percentage"
