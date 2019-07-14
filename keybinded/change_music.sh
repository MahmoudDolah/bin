#!/usr/bin/env bash
#
# A simple script to change my music and
# send a notification of the current song

# This prevents the notfications stacking and write
# over each other.

if pgrep -x ncmpcpp > /dev/null
then
    echo 1
else dunstify -r 123 "Now Playing ♫" "$(mpc current)"
fi
