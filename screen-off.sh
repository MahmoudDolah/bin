#!/usr/bin/env bash
#
# This turns off my screen. To add a little security, my lockscreen is enabled
# so that when I press any key to turn on my screen, I will be greeted with
# my lockscreen
betterlockscreen -l &
sleep 0.1
xset -display :1 dpms force off
