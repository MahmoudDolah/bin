#!/usr/bin/env bash

_command="$1"

if [ "$1" == "toggle" ]; then
    if [ $(playerctl status) == "Paused" ]; then
        _command="play"
    else
        _command="pause"
    fi
fi



playerctl --player="spotify,mpd" "$_command"
