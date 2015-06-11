#!/bin/bash -x

source $HOME/.config/bar/xcolors.sh
source $HOME/.config/bar/bar_config.sh

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Import seperate config files
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
render_side=()
render_function=()

register_renderer() {
    render_def_side="$1"
    render_def_function="$2"
    render_id="${#render_side[@]}"
    case $render_def_side in
        right|center|left)
            render_side[$render_id]=${render_def_side:0:1}
            render_function[$render_id]="$render_def_function"
            ;;
        *)
            echo "$render_def_function tried to render on $render_def_side" >&2
            ;;
    esac
    out_render_id=$render_id
}

update_renderer() {
    render_def_id="$1"
	shift
    render_def_data="$*"
    render_func="${render_function[$render_def_id]}"
    echo "id: $render_def_id function: $render_func" >&2
    render_string=$($render_func "$render_def_data")
    echo -ne "e:$render_def_id\t"
    #Render events are in the format {1char: side ; *char: text}
    echo -n "${render_side[$render_def_id]};"
    echo "$render_string"
}

post_data() {
    render_def_id="$1"
	echo "Posting data from $render_def_id" >&2
	shift
    render_def_data="$*"
    update_renderer "$render_def_id" "$render_def_data"
}

render_all_cache() {
    declare -a render_cache_selected=("${!1}")
    cnt=${#render_cache_selected[@]}
    for ((i=0;i<cnt;i++)); do
        echo -n "${render_cache_selected[i]}"
        if [[ $i < $(expr $cnt - 1) ]]; then
            echo -n "$separator"
        fi
    done
}

pollblock_command=()
pollblock_min_interval=5
pollblock_id=()
pollblock_linebuffer=()

pollblock_register() {
    echo "Register pollblock for command ($1) with id $3" >&2
    pollblock_command+=("$1")
    pollblock_id+=("$3")
    cnt=${#pollblock_command[@]}    
    if [[ $pollblock_min_interval > $2 ]]; then
        pollblock_min_interval="$2"
    fi
}

separator="%{F$separator_col}$separator"
{
    echo "Loading modules" >&2
	_modfiles="$HOME/.config/bar/active_modules/*.sh"
    for r in $_modfiles; do
        echo "bar: reading module $r" >&2
        source $r
    done
    while $running; do
        cnt=${#pollblock_command[@]}
        for ((i=0;i<cnt;i++)); do  
            retval=$(${pollblock_command[$i]})

            if [[ $retval != ${pollblock_linebuffer[$i]} ]]; then
                post_data "${pollblock_id[$i]}" "$retval"
            fi
        done

        sleep $pollblock_min_interval
    done
} | {
    render_cache_right=()
    render_cache_center=()
    render_cache_left=()
    while true ; do

        # wait for next event
        IFS=$'\t' read -ra cmd || break
        event=${cmd[0]}
        data=${cmd[@]:1}
        case "$event" in
            e*)
                event_id="${event:2}"
                IFS=";" read -ra COMMAND <<< "$data"
                case ${COMMAND[0]} in
                    r)
                        render_cache_right["$event_id"]="${COMMAND[1]}"
                        ;;
                    c)
                        render_cache_center["$event_id"]="${COMMAND[1]}"
                        ;;
                    l)
                        render_cache_left["$event_id"]="${COMMAND[1]}"
                        ;;
                    *)
                        echo "tried to render $event_id to ${COMMAND[1]}" >&2
                        ;;
                esac
                ;;
        esac
		
		for (( curMon=0; curMon < monitors; curMon++ )); do
				echo -n "%{S$curMon}"
				echo -n "%{l}"
				echo -n " "
				render_all_cache render_cache_left[@]
				echo -n "%{c}"
				render_all_cache render_cache_center[@]
				echo -n "%{r}"
				render_all_cache render_cache_right[@]
				echo -n " "
		done
		echo
    done

} | bar -g ${panel_width}x${panel_height}+${x}+${y} -f "$font" -B "$bar_bg_color" -F "$bar_fg_color" -u 5
