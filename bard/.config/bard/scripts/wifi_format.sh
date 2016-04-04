essid=$1
quality=$2

if [[ -z $essid ]]; then
	essid="Not connected"
fi

echo -n "%{T\$font[icon]}"
if [[ quality -gt 80 ]]; then
	echo -en "%{F\$xcolor[blue]}\uE222"
elif [[ quality -gt 40 ]]; then
	echo -en "%{F\$xcolor[yellow]}\uE221"
elif [[ quality -gt 20 ]]; then
	echo -en "%{F\$xcolor[red]}\uE220"
else
	echo -en "%{F\$xcolor[red]}\uE21F"
fi
echo " %{T-}%{F-}$essid"
