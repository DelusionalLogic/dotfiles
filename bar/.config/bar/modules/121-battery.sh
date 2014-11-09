battery_icon() {
    if [ "$battery_status" == "Charging" ]; then
        icon battery_charging battery_charging
    elif [[ $battery_percentage == 100 ]]; then
        icon battery_full battery_full
    elif [ "$battery_status" == "Discharging" ] && [[ $battery_percentage > 10 ]]; then
        icon battery_discharging battery_discharging
    else
        icon battery_low battery_low
    fi
}

battery_percentage() {
    echo -n $(setcolor battery_text)
    if [[ $battery_status == "Charging" ]]; then
        echo "+$battery_percentage%%"
    else
        echo "$battery_percentage%%"
    fi
}

battery_draw() {
    battery_acpi=$1
    battery_status=$(echo "$battery_acpi" | cut -d ' ' -f 3 | tr -d ',')
    battery_percentage=$(echo "$battery_acpi" | cut -d "," -f 2 | tr -d " %")
    echo -n $(battery_icon) $(battery_percentage)
}

register_renderer "right" "battery_draw"
battery_id=$out_render_id

pollblock_register "acpi -b" 1 $battery_id
