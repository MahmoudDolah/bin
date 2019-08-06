#!/usr/bin/env bash

# This is widget for show the calendar
urxvt -hold -name "calwidget" -e sh -c 'printf "\\e]11;#0d0b0a\\e\\\\" && printf "\033]708;#0d0b0a\007" && tput civis && PS1="" && stty -echo && clear && cal' &
sleep 0.07
i3-msg "[id=$(xdotool getactivewindow)]" floating enable
xdotool getactivewindow windowsize 208 159 windowmove 12 19
