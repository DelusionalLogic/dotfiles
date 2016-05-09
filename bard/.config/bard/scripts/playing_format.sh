state=$1
playing=$2
if [[ $state = "false" ]]; then
	exit 1
fi
echo -en "%{F\$xcolor[blue]}%{T\$font[icon]}%{T-}%{F-} $playing"
