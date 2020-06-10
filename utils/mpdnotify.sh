#!/usr/bin/env bash
#
# A very neat script which show the album art in and song info on music
# change in mpd
#
# The extrct_cover function is take from Kunst written by sdushantha, but this
# hack is written by sadparadiseinhell. 


mkdir -p /tmp/mpdnotify
pidfile=/tmp/mpdnotify/pidfile

MUSIC_DIR=$HOME/music/
COVER=/tmp/cover.png
SIZE=100x100

extract_cover() {

    ffmpeg -i "$MUSIC_DIR$(mpc current -f %file%)" $COVER -y &> /dev/null

	STATUS=$?

	if [ $STATUS -eq 0 ];then
        if [ ! $SILENT ];then 
            echo "extracted album art"
        fi
    fi

	if [ $STATUS -ne 0 ];then
        if [ ! $SILENT ];then
            echo "error: file does not have an album art"
        fi
	fi

}


while true; do
    mpc current --wait &>/dev/null
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
            mpc idle player &>/dev/null && (mpc status | grep "\[playing\]" &>/dev/null) && break
        done
        
    done
done
