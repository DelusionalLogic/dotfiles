volume_icon() {
	echo "$volume_status" >&2
	if [[ "$volume_status" == "off" ]]; then
		icon volume_muted volume_muted
	else
		icon volume_non_muted volume_non_muted
	fi
}

volume_draw() {
	volume_pulse="$1"
	volume_level=$(echo "$volume_pulse" | grep "Front Left:" | cut -d "[" -f 2 | tr -d " %]")
	volume_status=$(echo "$volume_pulse" | grep "Front Left:" | cut -d "[" -f 3 | tr -d "]")
	echo -n "$(volume_icon) $(textcolor volume_text "$volume_level%%")"
}

register_renderer "right" "volume_draw"
volume_id=$out_render_id

pollblock_register "amixer -D pulse sget Master" 10 $volume_id

