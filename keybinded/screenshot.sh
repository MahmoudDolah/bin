#!/usr/bin/env bash

# Take a screenshot and then display the screenshot
# using mpv as a little preview thing.
FNAME="$HOME/pictures/screenshots/screenshot_$(date +%y-%m-%d_at_%H-%M-%S).png"

if [[ $1 = "-s" ]];then
    # Select an area or click a window to take a screenshot of 
    # just the window
    maim -s -u $FNAME 
    mpv $FNAME
else
    # Screenshot of whole screen
    maim -u $FNAME
    mpv $FNAME

fi
