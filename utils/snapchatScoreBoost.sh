#!/usr/bin/env bash
#
# Siddharth Dushantha 2020
#
# This script basically automates what is shown in this YouTube
# video --> https://www.youtube.com/watch?v=-zMdDY5f6bM
#
# I used scrcpy to mirror my phone.
# NOTICE: You will have to modify the coordinates depending on your phone
#         size, where the scrcpy window is, etc
#
#         You can use
#          xdotool getmouselocation --shell
#         to get the coordinates of where to click
#
# Is this pointless?
#  Yes, but I had a compition with a friend who could get
#  the highest snapscore in 1 week
          

# Take 8 snaps
for run in {1..8}
do
    xdotool mousemove 717 736 click 1
    sleep 1
done

# Click on "Okay" when the Multi Snap Full dialog apears
xdotool mousemove 731 515 click 1
sleep 2

# Press the blue send button
xdotool mousemove 881 822 click 1
sleep 2

# Click on "Last Snap" which is under the "Recents" heading
xdotool mousemove 639 491 click 1

sleep 1
# Click on the send arrow
xdotool mousemove 882 831 click 1
