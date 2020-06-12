#!/bin/sh
#
# A very neat script which show the album art in and song info on music
# change in mpd
#
# The extrct_cover function is take from Kunst written by sdushantha, but this
# hack is written by sadparadiseinhell. 

MUSIC_DIR=$HOME/music/
COVER=/tmp/cover.png

pre_exit() {
    # This functions holds all the commands
    # to run when exiting the script
    rm /tmp/mpdnotify
}

extract_cover() {
    ffmpeg -i "$MUSIC_DIR$(mpc current -f %file%)" $COVER -y > /dev/null 2>&1
	STATUS=$?

	if [ "$STATUS" -eq 0 ]; then
        echo "extracted album art"
    fi

	if [ "$STATUS" -ne 0 ]; then
        echo "error: file does not have an album art"
	fi

}

# Prevent the user from doing CTRL+Z because that means
# pre_exit will not be executed.
trap "" TSTP

if [ -f /tmp/mpdnotify ]; then
    echo "mpdnotify is already running"
    exit 1
else
    # When the user presses CTRL+C, or the script justs exits, run pre_exit
    trap pre_exit EXIT
    touch /tmp/mpdnotify
fi

while true; do
    mpc current --wait > /dev/null 2>&1
    STATUS=$?

    while true; do
        extract_cover
        
        if [ $STATUS -eq 0 ]; then
            # Using -r we can replace the id of this notification. The reason
            # why we are doing this is so that the notifications dont stack
            # on top of each other and instead, it kills the previous one
            dunstify -r 6384 -i $COVER "$(mpc current -f "%title%")" "$(mpc current -f "%artist% - %album%")"
        fi

        rm /tmp/cover.png

        while true; do
            mpc idle player > /dev/null 2>&1
            mpc status | grep "\[playing\]" > /dev/null 2>&1
            break
        done
        
    done
done
