#!/bin/sh

dwm_updates () {
    UPDATES=$(checkupdates | wc -l)
    printf "%s" "$SEP1"
    if [ "$IDENTIFIER" = "unicode" ]; then
        printf "📡 %s updates" "$UPDATES"
    else
        printf "U %s updates" "$UPDATES"
    fi
    printf "%s\n" "$SEP2"
}

dwm_updates
