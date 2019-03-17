#!/bin/bash

if pgrep -x ncmpcpp > /dev/null
then
    echo 1
else notify-send "Now Playing ♫" "$(mpc current)"
fi
