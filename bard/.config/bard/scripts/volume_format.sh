if [[ "$1" = "on" ]]; then
	echo -en "%{F\$xcolor[green]}%{T\$font[icon]}\uE050%{F-} $2"
else
	echo -en "%{F\$xcolor[red]}%{T\$font[icon]}%{F-} $2"
fi
echo ""
