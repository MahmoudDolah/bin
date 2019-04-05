#!/usr/bin/env bash

# This is where the wallpaper which is going to be used is stored
path=~/.wallpaper

# Delete current wallpaper
rm $path*

# Copy given image to the Wallpaper directory
cp $1 $path

# Set the wallpaper using feh
feh --bg-fill $path*

# Updates the image for betterlockscreen
betterlockscreen -u $path* &> /dev/null
notify-send "ranger" "Image set as wallpaper and lockscreen"
