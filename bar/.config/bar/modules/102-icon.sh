icon() {
	echo "Loading icon $1" >&2
    echo -en "%{F${color["$2"]}}${icons[$1]}"
}
