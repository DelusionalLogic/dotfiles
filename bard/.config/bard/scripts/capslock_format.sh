if [[ "$status" == "on" ]]; then
	echo -en "%{F$on_col}%{T$icon}\uE0AE Caps"
else
	echo -en "%{F$off_col}%{T$icon}\uE0AE Caps"
fi
echo ""
