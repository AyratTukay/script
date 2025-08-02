#!/bin/bash
PREFIX="${1:-NOT_SET}"
INTERFACE="$2"
SUBNET="$3"
HOST="$4"

checking_host() {
	for HOST in {0..255}
		do
			echo "[*] IP : ${PREFIX}.${SUBNET}.${HOST}"
			arping -c 3 -i "$INTERFACE" "$PREFIX"".""$SUBNET"".""${HOST}" 2> /dev/null
		done
}

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi
[[ "$PREFIX" = "NOT_SET" ]] && { echo "\$PREFIX must be passed as first positional argument"; exit 1; }
if [[ -z "$INTERFACE" ]]; then
    echo "\$INTERFACE must be passed as second positional argument"
    exit 1
elif [[ -z "$SUBNET" && -z "$HOST" ]]; then
	for SUBNET in {0..255}
	do
		checking_host
	done
elif [[ -z "$HOST" ]]; then
	checking_host
else 
	arping -c 3 -i "$INTERFACE" "$PREFIX"".""$SUBNET"".""${HOST}" 2> /dev/null
fi#!/bin/bash
PREFIX="${1:-NOT_SET}"
INTERFACE="$2"
SUBNET="$3"
HOST="$4"

checking_host() {
	for HOST in {0..255}
		do
			echo "[*] IP : ${PREFIX}.${SUBNET}.${HOST}"
			arping -c 3 -i "$INTERFACE" "$PREFIX"".""$SUBNET"".""${HOST}" 2> /dev/null
		done
}

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi
[[ "$PREFIX" = "NOT_SET" ]] && { echo "\$PREFIX должен быть передан как первый позиционный аргумент"; exit 1; }
if [[ -z "$INTERFACE" ]]; then
    echo "\$INTERFACE должен быть передан как второй позиционный аргумент"
    exit 1
elif [[ -z "$SUBNET" && -z "$HOST" ]]; then
	for SUBNET in {0..255}
	do
		checking_host
	done
elif [[ -z "$HOST" ]]; then
	checking_host
else 
	arping -c 3 -i "$INTERFACE" "$PREFIX"".""$SUBNET"".""${HOST}" 2> /dev/null
fi
