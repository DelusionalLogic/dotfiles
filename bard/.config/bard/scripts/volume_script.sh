echo $(amixer -D pulse sget Master)
pactl subscribe | grep --line-buffered "sink #1" \
	| while read -r line; do
		while read -t 0.01; do
			:
		done
		echo $(amixer -D pulse sget Master)
	done
