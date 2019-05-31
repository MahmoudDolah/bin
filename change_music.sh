#!/usr/bin/env bash
#
# A simple script to change my music and
# send a notification of the current song

if pgrep -x ncmpcpp > /dev/null
then
    echo 1
else notify-send "Now Playing ♫" "$(mpc current)"
fi
