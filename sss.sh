#!/usr/bin/env bash

dir=~/Stuff/Screenshots/maim
name="maim-$(date +%F_%H:%M:%S)"

mkdir -p "$dir" || exit 1

newname() {
    name1="${name}-$(file ${dir}/${name}.png | awk '{gsub(",","")} {print $5 "x" $7}')" &&
    mv ${dir}/${name}.png ${dir}/${name1}.png
}

case $1 in
    -f)
        maim -ui $(xdotool getactivewindow) "${dir}/${name}.png" &&
        newname &&
        notify-send -i $dir/$name1.png  -t 2000 "Screenshot of focused window taken";;
    -s)
        maim -su -l -c 0.64314,0.41176,0.70588,0.2 -b 1 "${dir}/${name}.png" &&
        newname &&
        notify-send -i $dir/$name1.png  -t 2000 "Screenshot of selection taken";;
    *)
        maim -u "${dir}/${name}.png" &&
        newname &&
        notify-send -i $dir/$name1.png -t 2000 "";;
esac
