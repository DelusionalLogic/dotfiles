herbst_bar_pid=$!

bspwm_render_wintitle() {
	echo "$(setcolor bar_window_title)$1"
}

bspwm_render_tags() {
	IFS=$':' 
	for i in $1 ; do
		tagfgcol=""
		tagstr=""
		case ${i:0:1} in
			'F')
				tagfgcol="bar_tag_selected"
				tagstr=" - "
				;;
			'f')
				tagfgcol="bar_tag_notselected"
				tagstr=" - "
				;;
			'o')
				tagfgcol="bar_tag_notselected"
				tagstr=" + "
				;;
			'O')
				tagfgcol="bar_tag_selected"
				tagstr=" + "
				;;
			'M' | 'W' | 'm')
				echo -n "$(setxcolor brightmagenta)["
				;;
			'L')
				echo -n "$(setxcolor brightmagenta)]"
				;;
			*)
				continue
				;;
		esac
		if [[ ! -z $tagstr ]] ; then
			echo -n "$(setcolor $tagfgcol)"
			# clickable tags
			echo -n "%{A:settag ${i:1}:}"
			echo -n "$tagstr" #${i:1} to get the text
			echo -n "%{A}"
		fi
	done
}

register_renderer "left" "bspwm_render_wintitle"
bspwm_wintitle_id=$out_render_id

register_renderer "center" "bspwm_render_tags"
bspwm_tags_id=$out_render_id

{
	xtitle -s | {
		while true; do
				read -ra title || break
				post_data $bspwm_wintitle_id ${title[@]}
		done
		}
} &

{ 
	bspc control --subscribe | {
		while true; do
		    read -ra cmd || break
		    echo "${cmd[0]}" >&2
		    # find out event origin
			post_data $bspwm_tags_id ${cmd[@]}
		done
	}
} &
