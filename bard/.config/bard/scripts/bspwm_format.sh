IFS=$':'
grpcol="\$xcolor[gray]"
for i in $1 ; do
	tagfgcol=""
	tagstr=""
	first=false
	if [[ ${i:0:1} == 'W' ]]; then
		i=${i:1:-1}
		first=true
	fi
	case ${i:0:1} in
		'F')
			tagfgcol="\$xcolor[grey]"
			tagstr=" %{T\$font[icon]}+ "
			;;
		'f')
			tagfgcol="\$xcolor[grey]"
			tagstr=" %{T\$font[icon]}- "
			;;
		'o')
			tagfgcol="\$xcolor[yellow]"
			tagstr=" %{T\$font[icon]}- "
			;;
		'O')
			tagfgcol="\$xcolor[yellow]"
			tagstr=" %{T\$font[icon]}+ "
			;;
		'm')
			[ $first = false ] && echo -n " "
			echo -n "%{F\$xcolor[grey]}["
			grpcol="\$xcolor[grey]"
			;;
		'M')
			[ $first = false ] && echo -n " "
			echo -n "%{F\$xcolor[red]}["
			grpcol="\$xcolor[red]"
			;;
		'L')
			echo -n "%{F$grpcol}]"
			;;
		*)
			continue
			;;
	esac
	if [[ ! -z $tagstr ]] ; then
		echo -en "%{F$tagfgcol}"
		# clickable tags
		echo -en "$tagstr" #${i:1} to get the text
	fi
done
