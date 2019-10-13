#!/bin/sh

# A dwm_bar function that shows the current date and time
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Date is formatted like like this: "[Mon 01-01-00 00:00:00]"
dwm_public_ip () {
	ip="$(dig +short myip.opendns.com @resolver1.opendns.com)"
	echo [🌐${ip}]
}

dwm_public_ip
