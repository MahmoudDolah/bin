ARGUMENT="$1"
get_mpd_status(){
    if [ $(mpc status | grep -oP "\[(.*)\]") == "[paused]" ]; then
        mpd_status=0
    else
        mpd_status=1
    fi
    }

get_spotify_status(){
    ID=$(pgrep spotify)
    if [ ${#ID} -gt 2 ];then
        if [ $(playerctl status) == "Paused" ]; then
            spotify_status=0
        else
            spotify_status=1
        fi
    else
        spotify_status=0
    fi
}
action(){
    if [ $player == "mpd" ]; then
        case "$ARGUMENT" in
            "toggle")
               mpc toggle 
                ;;
            "next")
                mpc next
                ;;
            "prev")
                mpc prev
                ;;
            *)
                echo "Error: $ARGUMENT is an unrecognised argument"
                ;;
        esac
    else
        case "$ARGUMENT" in
            "toggle")
                playerctl play-pause
                ;;
            "next")
                playerctl next
                ;;
            "prev")
                playerctl previous
                ;;
            *)
                echo "Error: $ARGUMENT is an unrecognised argument"
                ;;
        esac
    fi

}

main(){
    get_mpd_status
    get_spotify_status
    # Check if both mpd and Spotify are running because
    # we cant control both at the same time
    # This statement makes no sense. Its true no matter what
    if [ $mpd_status -eq 0 ] || [ $mpd_status > $spotify_status ]; then
        echo "connected to mpd"
        player="mpd"
        action

    elif [ $spotify_status > $mpd_status ];then
        echo "connected to spotify"
        player="spotify"
        action
    elif [ $mpd_status -eq 1 ] && [ $spotify_status -eq 1 ]; then
        echo "Both are running, unable to control"
        exit 1
    fi

}

main

