essid=$3
quality=$5

if [[ -z $essid ]]; then
	essid="Not connected"
fi

echo -n "%{T\$font[icon]}"
if [[ quality -gt 80 ]]; then
	echo -en "%{F\$color[blue]}\uE222"
elif [[ quality -gt 40 ]]; then
	echo -en "%{F\$color[yellow]}\uE221"
elif [[ quality -gt 20 ]]; then
	echo -en "%{F\$color[red]}\uE220"
else
	echo -en "%{F\$color[red]}\uE21F"
fi
echo " %{T-}%{F-}$essid"
