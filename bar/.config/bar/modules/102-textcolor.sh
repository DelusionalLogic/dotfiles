setcolor() {
	echo "%{F${color["$1"]}}"
}

textcolor() {
	echo "$(setcolor "$1")$2"
}

setxcolor() {
	echo "%{F$(getcolor $1)}"
}
