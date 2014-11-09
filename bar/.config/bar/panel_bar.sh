#!/bin/bash

hc() { "${herbstclient_command[@]:-herbstclient}" "$@" ;}
monitor=${1:-0}
geometry=( $(herbstclient monitor_rect "$monitor") )
if [ -z "$geometry" ] ;then
    echo "Invalid monitor $monitor"
    exit 1
fi
# geometry has the format W H X Y
x=${geometry[0]}
y=${geometry[1]}
panel_width=
panel_height=14

font="-misc-stlarch-*-*-*-*-10-*-*-*-*-*-*-*,-*-terminus-*-*-*-*-12-*-*-*-*-*-*-*"

if awk -Wv 2>/dev/null | head -1 | grep -q '^mawk'; then
    # mawk needs "-W interactive" to line-buffer stdout correctly
    # http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=593504
    uniq_linebuffered() {
      awk -W interactive '$0 != l { print ; l=$0 ; fflush(); }' "$@"
    }
else
    # other awk versions (e.g. gawk) issue a warning with "-W interactive", so
    # we don't want to use it there.
    uniq_linebuffered() {
      awk '$0 != l { print ; l=$0 ; fflush(); }' "$@"
    }
fi

hc pad $monitor $panel_height

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Import seperate config files
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
render_array_right=()
render_array_center=()
render_array_left=()

register_renderer() {
    render_id=${#render_side[@]}
    case $1 in
        "right")
            render_array_right+=("$2")
            ;;
        "center")
            render_array_center+=("$2")
            ;;
        "left")
            render_array_left+=("$2")
            ;;
        *)
            echo "$2 tried to render on $1" >&2
            ;;
    esac
}

echo "Loading modules"
for r in $HOME/.config/bar/modules/*.sh; do
    echo "bar: reading module $r" >&2
    source $r
done

render_modules_left() {
    cnt=${#render_array_left[@]}
    for ((i=0;i<cnt;i++)); do
        echo "rendering module: ${render_array_left[i]}" >&2
        eval "${render_array_left[i]}"
        if [[ $i < $(expr $cnt - 1) ]]; then
            echo -n "$1"
        fi
    done
}

render_modules_center() {
    cnt=${#render_array_center[@]}
    for ((i=0;i<cnt;i++)); do
        echo "rendering module: ${render_array_center[i]}" >&2
        eval "${render_array_center[i]}"
        if [[ $i < $(expr $cnt - 1) ]]; then
            echo -n "$1"
        fi
    done
}

render_modules_right() {
    cnt=${#render_array_right[@]}
    for ((i=0;i<cnt;i++)); do
        echo "rendering module: ${render_array_right[i]}" >&2
        eval "${render_array_right[i]}"
        if [[ $i < $(expr $cnt - 1) ]]; then
            echo -n "$1"
        fi
    done
}

render_all_modules() {
        echo -n "%{l}"
    render_modules_left "$1"
        echo -n "%{c}"
    render_modules_center "$1"
        echo -n "%{r}"
    render_modules_right "$1"
}

separator=" $(setcolor bar_separator)| "

{
    while true ; do
        text="$(render_all_modules "$separator")"
        echo -ne "right\t"
        echo "$text"
        sleep 3 || break
    done > >(uniq_linebuffered) &
    childpid=$!
    hc --idle
    kill $childpid
} | {
    IFS=$'\t' read -ra tags <<< "$(hc tag_status $monitor)"
    visible=true
    right_text=""
    windowtitle=""
    while true ; do

        ### Output ###
        # This part prints dzen data based on the _previous_ data handling run,
        # and then waits for the next event to happen.

        echo -n "$(setcolor bar_window_title) ${windowtitle//^/^^}"


        echo -n "%{c}"
        # draw tags
        for i in "${tags[@]}" ; do
            tagfgcol=""
            case ${i:0:1} in
                '.')
                    tagfgcol="bar_tag_empty"
                    ;;
                ':')
                    tagfgcol="bar_tag_noselected"
                    ;;
                '+')
                    tagfgcol="bar_tag_thismon_noselected"
                    ;;
                '#')
                    tagfgcol="bar_tag_thismon_selected"
                    ;;
                '-')
                    tagfgcol="bar_tag_diffmon_noselected"
                    ;;
                '%')
                    tagfgcol="bar_tag_diffmon_selected"
                    ;;
                '!')
                    tagfgcol="bar_tag_urgent"
                    ;;
            esac
            echo -n "$(setcolor $tagfgcol)"
            # clickable tags
            echo -n "%{A:settag ${i:1}:}"
            echo -n " ${i:1}" #${i:1} to get the text
            echo -n "%{A}"
        done

        echo -n "$right_text "

        echo

        ### Data handling ###
        # This part handles the events generated in the event loop, and sets
        # internal variables based on them. The event and its arguments are
        # read into the array cmd, then action is taken depending on the event
        # name.
        # "Special" events (quit_panel/togglehidepanel/reload) are also handled
        # here.

        # wait for next event
        IFS=$'\t' read -ra cmd || break
        # find out event origin
        case "${cmd[0]}" in
            tag*)
                #echo "resetting tags" >&2
                IFS=$'\t' read -ra tags <<< "$(hc tag_status $monitor)"
                ;;
            quit_panel)
                exit
                ;;
            right)
                right_text="${cmd[@]:1}"
                ;;
            reload)
                exit
                ;;
            focus_changed|window_title_changed)
                windowtitle="${cmd[@]:2}"
                ;;
            #player)
            # ;;
        esac
    done

} | bar -g ${panel_width}x${panel_height} -f "$font" -B "${color["bar_bg"]}" -F "${color["bar_fg"]}" -u 5
