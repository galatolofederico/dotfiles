#!/bin/sh

jackd -dalsa -r48000 -p256 -D -Chw:Microphone -Phw:PCH &
sleep 5;
notify-send "Jack server started" -t 3000

pactl unload-module module-jack-sink
pactl unload-module module-jack-source

pactl load-module module-jack-sink
pactl load-module module-jack-source

pacmd set-default-sink jack_out
pacmd set-default-source jack_in

sleep 2;

carla -n $HOME/.config/jack-config.carxp &
sleep 1;
jack_disconnect system:capture_1 "PulseAudio JACK Source:mono"
notify-send "Patchbay loaded" -t 3000
