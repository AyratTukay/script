#!/bin/bash
PREFIX="${1:-NOT_SET}"
INTERFACE="$2"
SUBNET="$3"
HOST="$4"

arping_com() {
	arping -c 3 -i "$INTERFACE" "$PREFIX"".""$SUBNET"".""${HOST}" 2> /dev/null
}

checking_host() {
	for HOST in {0..255}
		do
			echo "[*] IP : ${PREFIX}.${SUBNET}.${HOST}"
			arping_com
		done
}

trap 'echo "Ping exit (Ctrl-C)"; exit 1' 2
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi
[[ "$PREFIX" = "NOT_SET" ]] && { echo "\$PREFIX must be passed as first positional argument"; exit 1; }
[[ "$PREFIX" =~ ^(25[0-5]|2[0-4][0-9]|[0-1]?[0-9]{1,2})"."(25[0-5]|2[0-4][0-9]|[0-1]?[0-9]{1,2})$ ]] || { echo "\$PREFIX in wrong range"; exit 1; }
if [[ -z "$INTERFACE" ]]; then
    echo "\$INTERFACE must be passed as second positional argument"
    exit 1
elif [[ -z "$SUBNET" && -z "$HOST" ]]; then
	for SUBNET in {0..255}
	do
		checking_host
	done
elif [[ -z "$HOST" ]]; then
	[[ "$SUBNET" =~ ^(25[0-5]|2[0-4][0-9]|[0-1]?[0-9]{1,2})$ ]] || { echo "\$SUBNET in wrong range"; exit 1; }
	checking_host
else 
	[[ "$HOST" =~ ^(25[0-5]|2[0-4][0-9]|[0-1]?[0-9]{1,2})$ ]] || { echo "\$HOST in wrong range"; exit 1; }
	arping_com
fi
