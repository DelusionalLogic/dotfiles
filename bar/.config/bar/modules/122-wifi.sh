wireless_quality() {
	wifi_quality="$(echo "$1" | grep Quality | cut -d ' ' -f 2)"
	if [[ wifi_quality -gt 90 ]]; then
    	echo -n "$(icon wifi_good wifi_good)"
	elif [[ wifi_quality -gt 20 ]]; then
    	echo -n "$(icon wifi_bad wifi_bad)"
	else
    	echo -n "$(icon wifi_bad wifi_bad)"
	fi
}

wireless_name() {
    wifi_name="$(echo "$1" | grep Essid | cut -d ' ' -f 2)"
    if [[ -z $wifi_name ]]; then
    	wifi_name="Not connected"
    fi
    echo -n $(setcolor wifi_text)
	echo -n "$wifi_name"
}

wifi_draw() {
	wicd_data=$1
	echo -n "$(wireless_quality "$wicd_data") $(wireless_name "$wicd_data")"
}

register_renderer "right" "wifi_draw"
wifi_id=$out_render_id

pollblock_register "wicd-cli -yd" 10 $wifi_id
