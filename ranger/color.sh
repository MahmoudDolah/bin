#!/usr/bin/env bash
#
# Dependencies: wal
#
# This is script which allows me to change the background color
# of kitty terminal and my notification daemon, dunst 
# depending on the current wallpaper. This script is used
# in my wall.sh script which I run when I change my wallpaper
# from ranger.

WALLPAPER="$HOME/pictures/current/"
COLOR_FILE="$HOME/.cache/wal/colors"

# Generate the colors from current wallpaper
wal -e -n -s -q -i "$WALLPAPER"*

BG_COLOR=$(sed '1q;d' "$COLOR_FILE")


# just for debugging...
#echo "using $WALLPAPER as wallpaper"
#echo "bg  $BG_COLOR"

set_urxvt() {
    URXVT_CONFIG="$HOME/.Xresources"
    ZSHRC="$HOME/.zshrc"

    # Set the color
    echo "setting urxvt bg color xresources"
    sed -i s/"^\*\.background:.*/\*\.background:   $BG_COLOR"/g $URXVT_CONFIG
    echo "setting urxvt bg color zshrc"
    sed -i "s/BG_COLOR=\".*/BG_COLOR=\"$BG_COLOR\"/g" $ZSHRC

    for tty in /dev/pts/[0-9]*; do
        [[ -w $tty ]] &&
            # Change the background color
            printf "\\e]11;${BG_COLOR}\\e\\\\" > "$tty" &
            # Change the padding color. Only works on urxvt
            # Source: https://lazymalloc.com/index.php/2016/11/18/managing-the-internalborder-background-color-in-rxvt-unicode/
            printf "\033]708;${BG_COLOR}\007" > "$tty" &
    done

    xrdb "$HOME/.Xresources"
}


set_kitty() {
    KITTY_CONFIG="$HOME/.config/kitty/kitty.conf"
    ZSHRC="$HOME/.zshrc"

    # Set the color
    echo "Setting kitty bg color in config..."
    sed -i s/"^background.*/background $BG_COLOR"/g $KITTY_CONFIG
    echo "Setting kitty bg color in zshrc..."
    sed -i "s/BG_COLOR=\".*/BG_COLOR=\"$BG_COLOR\"/g" $ZSHRC

    for tty in /dev/pts/[0-9]*; do
        [[ -w $tty ]] &&
            printf "\\e]11;${BG_COLOR}\\e\\\\" > "$tty" &
    done
}


set_dunst(){
    # The regex is really bad, but it works :)

    # Path to dunst config file
    DUNSTRC="$HOME/.config/dunst/dunstrc"

    # Change the background of urgency low
    sed -z -i "s/    background............/    background = \"$BG_COLOR\"/1" $DUNSTRC

    # Change the background of urgency normal
    sed -z -i "s/    background............/    background = \"$BG_COLOR\"/2" $DUNSTRC

    # Change the border color of both urgncy low and normal
    sed -z -i "s/   frame_color = ........./   frame_color = \"$BG_COLOR\"/1" $DUNSTRC

    # Kill dunst so that it restart and use the updated config file
    killall dunst &> /dev/null
}

set_urxvt
set_dunst
set_kitty
