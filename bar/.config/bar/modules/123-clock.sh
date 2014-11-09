clock_draw() {
	echo -n "$(icon clock clock_icon)"
    echo -n "$(setcolor clock_text) "
	echo -n "$1"
}

register_renderer "right" "clock_draw"
clock_id=$out_render_id

pollblock_register "date +%H:%M" 10 $clock_id
