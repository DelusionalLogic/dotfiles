if [[ $state = "false" ]]; then
	exit 1
fi
echo -en "%{F$playing_col}%{T$icon}%{T-}%{F-} $playing"
