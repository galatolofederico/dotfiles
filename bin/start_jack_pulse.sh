#!/bin/sh

jackd -dalsa -r192000 -p512 -D -Chw:Microphone -Phw:PCH &
sleep 3;

pactl load-module module-jack-sink
pactl load-module module-jack-source

pacmd set-default-sink jack_out
pacmd set-default-source jack_in
