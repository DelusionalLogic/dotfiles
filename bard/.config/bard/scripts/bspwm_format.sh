function tag() {
	case ${i:0:1} in
		'm')
			echo "["
			return
			;;
		'M')
			echo "["
			return
			;;
		'L')
			echo "]"
			return
			;;
		'T')
			return
			;;
		'G')
			return
			;;
	esac

	workspace_name="${i:1}"

	local oldifs=$IFS
	IFS=$'\n'

	workspace_icon=""

	for w in $(bspc query -N -n .window -d "$workspace_name"); do
		classes=$(xprop -id $w WM_CLASS | cut -c 20-)
		if [[ $classes = *"Firefox"* ]]; then
			workspace_icon=" %{T$icon}\uE1BF%{T-} "
		fi

		if [[ $classes = *"Termite"* ]]; then
			workspace_icon=" %{T$icon}\uE1EF%{T-} "
		fi

		if [[ $classes = *"twitch"* ]]; then
			workspace_icon=" %{T$icon}\uE1D3%{T-} "
		fi

		if [[ $classes = *"google play music"* ]]; then
			workspace_icon=" %{T$icon}\uE04D%{T-} "
		fi

		if [[ $classes = *"Steam"* ]]; then
			workspace_icon=" %{T$icon}\uE1CE%{T-} "
		fi
	done

	if [[ ! -z $workspace_icon ]]; then
		echo -en $workspace_icon
		return
	fi

	IFS=$oldifs

	# bspc query -N -n .window -d 2 | parallel xprop -notype -id {} WM_CLASS
	case ${i:0:1} in
		'F')
			echo -en " %{T$icon}\uE1BC%{T-} "
			;;
		'f')
			echo -en " %{T$icon}\uE1BC%{T-} "
			;;
		'o')
			echo -en " %{T$icon}\uE1C2%{T-} "
			;;
		'O')
			echo -en " %{T$icon}\uE1C2%{T-} "
			;;
		*)
			continue
			;;
	esac
}

IFS=$':'
grpcol="$inactive_col"
echo "$input" >&2
for i in $input ; do
	tagfgcol=""
	tagstr=""
	first=false
	if [[ ${i:0:1} == 'W' ]]; then
		i=${i:1:-1}
		first=true
	fi
	tagstr=$(tag $i)
	case ${i:0:1} in
		'F')
			tagfgcol="$active_col"
			;;
		'f')
			tagfgcol="$inactive_col"
			;;
		'o')
			tagfgcol="$inactive_col"
			;;
		'O')
			tagfgcol="$active_col"
			;;
		'm')
			[ $first = false ] && echo -n " "
			tagfgcol="$inactive_col"
			grpcol="$inactive_col"
			;;
		'M')
			[ $first = false ] && echo -n " "
			tagfgcol="$sep_col"
			grpcol="$sep_col"
			;;
		'L')
			tagfgcol="$grpcol"
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
