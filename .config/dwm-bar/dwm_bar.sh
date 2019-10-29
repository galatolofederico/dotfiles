#!/bin/sh

# A modular status bar for dwm
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: xorg-xsetroot

# Import functions with "$include /route/to/module"
# It is recommended that you place functions in the subdirectory ./bar-functions and use: . "$DIR/bar-functions/dwm_example.sh"

# Store the directory the script is running from

# Script lock
lockfile=/tmp/dwmbar_lock_$(whoami)$DISPLAY

function unlock {
	rm $lockfile
	exit
}
trap unlock SIGTERM SIGKILL SIGINT

if [ -f $lockfile ]; then
	exit
fi
touch $lockfile

LOC=$(readlink -f "$0")
DIR=$(dirname "$LOC")

# Change the appearance of the module identifier. if this is set to "unicode", then symbols will be used as identifiers instead of text. E.g. [📪 0] instead of [MAIL 0].
# Requires a font with adequate unicode character support
export IDENTIFIER="unicode"

# Change the charachter(s) used to seperate modules. If two are used, they will be placed at the start and end.
export SEP1="["
export SEP2="]"

# Import the modules
. "$DIR/bar-functions/dwm_battery.sh"
. "$DIR/bar-functions/dwm_backlight.sh"
. "$DIR/bar-functions/dwm_pulse.sh"
. "$DIR/bar-functions/dwm_network.sh"
. "$DIR/bar-functions/dwm_date.sh"
. "$DIR/bar-functions/dwm_updates.sh"

# Update dwm status bar every second
i=0
while true
do
	dwm_battery=$(dwm_battery)
	dwm_backlight=$(dwm_backlight)
	dwm_pulse=$(dwm_pulse)
	dwm_network=$(dwm_network)
    dwm_date=$(dwm_date)
	if [ $((i % 60)) -eq 0 ]; then dwm_updates=$(dwm_updates); fi
	xsetroot -name "$dwm_battery$dwm_updates$dwm_backlight$dwm_pulse$dwm_network$dwm_date"
    sleep 1
done
