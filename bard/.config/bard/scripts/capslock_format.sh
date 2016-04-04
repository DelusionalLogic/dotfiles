if [[ "$1" = "on" ]]; then
	echo -en "%{F\$xcolor[blue]}%{T\$font[icon]}\uE0AE Caps"
else
	echo -en "%{F\$xcolor[grey]}%{T\$font[icon]}\uE0AE Caps"
fi
echo ""
