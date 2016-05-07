essid=$1

if [[ -z $essid ]]; then
	essid="Not connected"
	echo -en "%{F\$xcolor[red]}\uE21F"
	echo " %{T-}%{F-}$essid"
else
	echo -en "%{F\$xcolor[blue]}\uE222"
	echo " %{T-}%{F-}$essid"
fi

