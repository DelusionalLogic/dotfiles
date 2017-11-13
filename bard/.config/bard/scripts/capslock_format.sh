if [[ "$status" == "on" ]]; then
	echo -en "%{B$on_col} %{T$icon}\uE0AE Caps "
else
	echo -en "%{B$off_col} %{T$icon}\uE0AE Caps "
fi
echo ""
