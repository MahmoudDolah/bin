#!/usr/bin/env bash

# This is widget for show the calendar
kitty --hold --title="calwidget" -e sh -c ' printf "\\e]11;#0d0b0a\\e\\\\" && tput civis && PS1="" && stty -echo && clear && cal' &
sleep 0.3
i3-msg [title="calwidget"] focus, floating enable, resize set 188 175, move position 12 25

# Right = 1240
