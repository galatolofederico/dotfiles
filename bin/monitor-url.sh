#!/bin/sh

if [ "$#" -lt 1 ]; then
    echo "Usage $0 <url> <intervall (default: 60)"
    exit 
fi

INTERVALL=60
if [ "$#" -eq 2 ]; then
    INTERVALL=$2
fi

URL=$1
FILE_NEW=$(mktemp)
FILE_OLD=$(mktemp)

rm $FILE_NEW
rm $FILE_OLD

telegram-notify --warning --text "Now monitoring $URL whit intervall $INTERVALL"
while true; do
    if [ -f $FILE_NEW ]; then
        mv $FILE_NEW $FILE_OLD
    fi
    curl $URL -L --compressed -s > $FILE_NEW
    if [ -f $FILE_OLD ]; then
        if cmp -s $FILE_NEW $FILE_OLD; then
            echo "No changes"
        else
            telegram-notify --success --text "$URL has changed"
       fi
    fi
    sleep $INTERVALL 
done
