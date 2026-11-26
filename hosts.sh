#!/bin/bash

cat /etc/hosts | while read ip nume rest; do
    case "$ip" in
        ""|\#*|*:*) continue ;;
    esac

    if ! nslookup "$nume" | grep "^Address" | grep -v "#" | grep -qwF "$ip"; then
        echo "Bogus IP for $nume in /etc/hosts!"
    fi
done
