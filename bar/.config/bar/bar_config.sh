bar_bg_color=$(getcolor black)
bar_fg_color=$(getcolor white)

font="-misc-stlarch-*-*-*-*-10-*-*-*-*-*-*-*,-*-terminus-*-*-*-*-12-*-*-*-*-*-*-*"

monitors=2
panel_height=17

separator_col=$(getcolor grey)
separator=" | "

bspc config top_padding $panel_height
