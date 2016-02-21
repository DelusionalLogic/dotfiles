#!/bin/zsh
#
# a simple dmenu session script 
#
###

declare -A cmds
opts=(
	shutdown 
	logout
	reboot
	"---- GRUB ----"
)
cmds=(
	shutdown "shutdown now"
	logout "~/scripts/lock.sh &"
	reboot "reboot"
)

OLDIFS=$IFS
IFS='
'
for x in `~/scripts/listgrub.sh`; do
	opts+=("reboot into: $x")
	cmds+=("reboot into: $x" "gksu grub-reboot \"$x\" && reboot")
done
IFS=$OLDIFS

DMENU="rofi -dmenu -p action: -hide-scrollbar -fuzzy"
choice=$(printf '%s\n' "${(@)opts}" | $=DMENU)
if [[ -z "$choice" ]]; then exit 0; fi
eval "${cmds[$choice]}"
