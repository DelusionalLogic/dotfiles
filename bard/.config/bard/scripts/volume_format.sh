if [[ "$status" = "on" ]]; then
	volumeSlide=$(progress $volume 100 "%{F-}" "%{F$slider_col}" "%{F$slider_col}")
	echo -en "%{B$normal_col}%{T$icon}\uE050%{F-} $volumeSlide "
else
	volumeSlide=$(progress $volume 100 "%{F-}" "%{F$slider_col}" "%{F$slider_col}")
	echo -en "%{B$muted_col}%{T$icon}%{F-} $volumeSlide "
fi
echo ""
