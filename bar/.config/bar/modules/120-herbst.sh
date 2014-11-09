herbst_bar_pid=$!

herbst_render_wintitle() {
	echo "$(setcolor bar_window_title)$1"
}

herbst_render_tags() {
	echo -n "$(setxcolor brightgreen)[ "
	for i in "${tags[@]}" ; do
	tagfgcol=""
	tagstr=""
	case ${i:0:1} in
	    '.')
	        tagfgcol="bar_tag_empty"
	        tagstr=" - "
	        ;;
	    ':')
	        tagfgcol="bar_tag_noselected"
	        tagstr=" + "
	        ;;
	    '+')
	        tagfgcol="bar_tag_thismon_noselected"
	        tagstr=" + "
	        ;;
	    '#')
	        tagfgcol="bar_tag_thismon_selected"
	        tagstr=" * "
	        ;;
	    '-')
	        tagfgcol="bar_tag_diffmon_noselected"
	        tagstr=" + "
	        ;;
	    '%')
	        tagfgcol="bar_tag_diffmon_selected"
	        tagstr=" + "
	        ;;
	    '!')
	        tagfgcol="bar_tag_urgent"
	        tagstr=" ! "
	        ;;
	esac
	echo -n "$(setcolor $tagfgcol)"
	# clickable tags
	echo -n "%{A:settag ${i:1}:}"
	echo -n "$tagstr" #${i:1} to get the text
	echo -n "%{A}"
	done
	echo " $(setxcolor brightgreen)]"
}

register_renderer "left" "herbst_render_wintitle"
herbst_wintitle_id=$out_render_id

register_renderer "center" "herbst_render_tags"
herbst_tags_id=$out_render_id

{ 
	herbstclient --idle | {
		while true; do
		    IFS=$'\t' read -ra cmd || break
		    echo "${cmd[0]}" >&2
		    # find out event origin
		    case "${cmd[0]}" in
		        tag*)
		            #echo "resetting tags" >&2
		            IFS=$'\t' read -ra tags <<< "$(herbstclient tag_status $monitor)"
		            post_data $herbst_tags_id tags[@]
		            ;;
		        quit_panel)
		            kill 0
		            ;;
		        reload)
		            kill 0
		            ;;
		        focus_changed|window_title_changed)
		            post_data $herbst_wintitle_id "${cmd[@]:2}"
		            ;;
		        #player)
		        # ;;
		    esac
		done
	}
} &
