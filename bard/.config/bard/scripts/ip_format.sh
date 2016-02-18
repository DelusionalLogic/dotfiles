essid=$2

if [[ -z $essid ]]; then
	essid="Not connected"
	echo -en "%{F\$color[red]}\uE21F"
	echo " %{T-}%{F-}$essid"
else
	echo -en "%{F\$color[blue]}\uE222"
	echo " %{T-}%{F-}$essid"
fi

