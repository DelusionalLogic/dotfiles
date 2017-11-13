defaultSink=$(pacmd list-sinks | grep "* index" | sed 's/\s*\* index: //g')
echo $(amixer -D pulse sget Master)
pactl subscribe | grep --line-buffered "sink #" \
	| while read -r line; do
		while read -t 0.001; do
			:
		done
		echo $(amixer -D pulse sget Master)
	done
