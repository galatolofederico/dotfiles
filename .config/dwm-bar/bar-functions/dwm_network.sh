#!/bin/sh

dwm_network () {
    IF=$(ip route | awk '/^default/ { print $5 ; exit }')
    if [ ! -d /sys/class/net/${IF} ]; then
        exit
    fi
    IPADDR=$(ip addr show $IF | perl -n -e "/inet6? ([^\/]+).* scope global/ && print \$1 and exit")

    printf "%s" "$SEP1"
    if [ "$IDENTIFIER" = "unicode" ]; then
        printf "🌐 %s: %s" "$IF" "$IPADDR"
    else
        printf "NET %s: %s" "$IF" "$IPADDR"
    fi
    printf "%s\n" "$SEP2"
}

dwm_network
