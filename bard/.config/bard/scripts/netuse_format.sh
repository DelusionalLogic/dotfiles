if [ -z "$kbin" ] || [ -z "$kbout" ]; then
	exit 1
fi

kbin=$(bc -l <<< "scale=2; $kbin*8/1024" | awk '{ OFMT="%.2f"; print $1+0.0001 }')
kbout=$(bc -l <<< "scale=2; $kbout*8/1024" | awk '{ OFMT="%.2f"; print $1+0.0001 }')
echo -en "%{T$icon}%{B$downicon_col} \uE13C "
echo -n "%{F-}$kbin Mb "
echo -n "%{B-} "
echo -en "%{T$icon}%{B$upicon_col} \uE13B "
echo -n "%{F-}$kbout Mb "
echo ""
exit 0
