if [[ -z $ip ]]; then
	ip="Not connected"
	echo -en "%{F$nconnected_col}\uE21F"
	echo " %{T-}%{F-}$ip"
else
	echo -en "%{F$connected_col}\uE222"
	echo " %{T-}%{F-}$ip"
fi

