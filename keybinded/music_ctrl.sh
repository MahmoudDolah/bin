#!/usr/bin/env bash


send_notification(){
    if pgrep -x ncmpcpp > /dev/null
    then
        echo 1
    else dunstify -r 123 "Now Playing" "$(mpc current)"
    fi
}


_command="$1"

if [ "$1" == "toggle" ]; then
    if [ $(playerctl status) == "Paused" ]; then
        _command="play"
    else
        _command="pause"
    fi
fi



playerctl --player="spotify,mpd" "$_command"

if [ $(playerctl -l) != *"spotify"* ]; then
    send_notification
fi

