IFS=$':'
for i in $2 ; do
	tagfgcol=""
	tagstr=""
	case ${i:0:1} in
		'F')
			tagfgcol="\$color[grey]"
			tagstr=" %{T\$font[icon]}+ "
			;;
		'f')
			tagfgcol="\$color[grey]"
			tagstr=" %{T\$font[icon]}- "
			;;
		'o')
			tagfgcol="\$color[yellow]"
			tagstr=" %{T\$font[icon]}- "
			;;
		'O')
			tagfgcol="\$color[yellow]"
			tagstr=" %{T\$font[icon]}+ "
			;;
		'M' | 'W' | 'm')
			echo -n "%{F\$color[red]} ["
			;;
		'L')
			echo -n "%{F\$color[red]} ]"
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
