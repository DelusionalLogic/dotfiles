declare -A icons

icons["volume_muted"]=""
icons["volume_non_muted"]="\uE050"

icons["wifi_good"]=""
icons["wifi_bad"]=""

icons["battery_charging"]="\uE042"
icons["battery_full"]="\uE03B"
icons["battery_discharging"]="\uE03A"
icons["battery_low"]="\uE038"

icons["clock"]=""

declare -A color

color["none"]="-"

color["bar_window_title"]=$(getcolor white)
color["bar_tag_selected"]=$(getcolor red)
color["bar_tag_notselected"]=$(getcolor white)

color["volume_muted"]=$(getcolor red)
color["volume_non_muted"]=$(getcolor green)
color["volume_text"]=$(getcolor white)

color["wifi_good"]=$(getcolor blue)
color["wifi_bad"]=$(getcolor red)
color["wifi_text"]=$(getcolor white)

color["clock_icon"]=$(getcolor white)
color["clock_text"]=$(getcolor white)

color["battery_charging"]=$(getcolor brightgreen)
color["battery_full"]=$(getcolor green)
color["battery_discharging"]=$(getcolor yellow)
color["battery_low"]=$(getcolor brightred)
color["battery_text"]=$(getcolor white)
