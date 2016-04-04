IFS=$':'
for i in $1 ; do
	tagfgcol=""
	tagstr=""
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
		'M' | 'W' | 'm')
			echo -n "%{F\$xcolor[red]} ["
			;;
		'L')
			echo -n "%{F\$xcolor[red]} ]"
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
