IFS=$':' 
for i in $2 ; do
	tagfgcol=""
	tagstr=""
	case ${i:0:1} in
		'F')
			tagfgcol="\$color[green]"
			tagstr=" %{T\$font[icon]}\uE0F6 "
			;;
		'f')
			tagfgcol="\$color[grey]"
			tagstr=" %{T\$font[icon]}\uE0F6 "
			;;
		'o')
			tagfgcol="\$color[blue]"
			tagstr=" %{T\$font[icon]}\uE098 "
			;;
		'O')
			tagfgcol="\$color[green]"
			tagstr=" %{T\$font[icon]}\uE098 "
			;;
		'M' | 'W' | 'm')
			echo -n "%{F\$color[yellow]} "
			;;
		'L')
			echo -n "%{F\$color[yellow]} "
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
