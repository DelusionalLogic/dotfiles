if [[ $state = "false" ]]; then
	exit 1
fi
echo -en "%{B$playing_col}%{T$icon} %{T-}%{F-} $playing "
