if [[ "$status" = "on" ]]; then
	volumeSlide=$(progress $volume 100 "%{F$normal_col}" "%{F-}" "%{F$slider_col}")
	echo -en "%{F$normal_col}%{T$icon}\uE050%{F-} $volumeSlide"
else
	volumeSlide=$(progress $volume 100 "%{F$muted_col}" "%{F-}" "%{F$slider_col}")
	echo -en "%{F$muted_col}%{T$icon}%{F-} $volumeSlide"
fi
echo ""
