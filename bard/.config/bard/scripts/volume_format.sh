if [[ "$3" = "on" ]]; then
	echo -en "%{F\$color[green]}%{T\$font[icon]}\uE050%{F-} $2"
else
	echo -en "%{F\$color[red]}%{T\$font[icon]}%{F-} $2"
fi
echo ""
