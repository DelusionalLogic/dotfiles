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

color["bar_separator"]=$(getcolor grey)
color["bar_window_title"]=$(getcolor white)

color["bar_tag_empty"]=$(getcolor grey)
color["bar_tag_noselected"]=$(getcolor green)
color["bar_tag_thismon_noselected"]=$(getcolor grey) #Show here but not active
color["bar_tag_thismon_selected"]=$(getcolor brightblue) #Shown here and active
color["bar_tag_diffmon_noselected"]=$(getcolor grey) #Shown somewhere else but not active
color["bar_tag_diffmon_selected"]=$(getcolor grey) #Show somewhere else and active
color["bar_tag_urgent"]=$(getcolor brightred)

color["volume_muted"]=$(getcolor red)
color["volume_non_muted"]=$(getcolor brightgreen)
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
