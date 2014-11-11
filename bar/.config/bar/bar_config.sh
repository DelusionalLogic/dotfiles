bar_bg_color=$(getcolor black)
bar_fg_color=$(getcolor white)

font="-misc-stlarch-*-*-*-*-10-*-*-*-*-*-*-*,-*-terminus-*-*-*-*-12-*-*-*-*-*-*-*"

monitor=${1:-0}
panel_height=17

bspc config top_padding $panel_height
