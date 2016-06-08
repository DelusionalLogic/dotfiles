if [[ "$status" = "on" ]]; then
	echo -en "%{F$normal_col}%{T$icon}\uE050%{F-} $volume"
else
	echo -en "%{F$muted_col}%{T$icon}%{F-} $volume"
fi
echo ""
