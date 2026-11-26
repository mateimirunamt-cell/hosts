#!/bin/bash

verifica() {
    nume="$1"
    ip="$2"
    dns="$3"

    if ! nslookup "$nume" "$dns" | grep "^Address" | grep -v "#" | grep -qwF "$ip"; then
        echo "Bogus IP for $nume in /etc/hosts!"
    fi
}

cat /etc/hosts | while read ip nume rest; do
    case "$ip" in
        ""|\#*|*:*) continue ;;
    esac

    verifica "$nume" "$ip" 8.8.8.8
done
