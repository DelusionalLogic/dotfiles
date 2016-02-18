playing=$1
if [[ -z $playing ]]; then
	exit 1
fi
echo -en "%{F\$color[blue]}%{T\$font[icon]}%{T-}%{F-} $1"
