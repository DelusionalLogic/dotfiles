#!/bin/bash

#======~===~==============~===========~==
# COLORS
#==~==========~=========~=============~~=

# get xresource colors
# read xresource colors to array "xrdb"
xrdb=( $(xrdb -query | grep -P "color[0-9]*:" | sort | cut -f 2- -d "#") )

# `sort` doesn't quite sort ascending, it sorts "0, 10, 11, 12, ..., 1, 2, 3, ...", so we need to fix.
# while we're at it, we might as well use proper names.

# define array "xcolor" (actually a hash table)
declare -A xcolor

# need this to get the values from xrdb one by one
index=0

# loop over color names
for name in black brightgreen brightyellow brightblue brightmagenta brightcyan brightwhite red green yellow blue magenta cyan white grey brightred; do
    # assign color value from array xrdb to hash "color"
    xcolor[${name}]="#${xrdb[$index]}"
    # increase "index" by one, so we get the next color value for the next iteration
    ((index++))
done

getcolor() {
	echo "${xcolor["$1"]}"
}

dmenu_run -nb "$(getcolor black)" -nf $(getcolor white) -sb $(getcolor blue) -p "Run: " -fn "-*-terminus-*-*-*-*-12-*-*-*-*-*-*-*"
