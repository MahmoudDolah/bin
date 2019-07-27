red=${1:0:2}
green=${1:2:2}
blue=${1:4:2}

red=$(printf "%d\n" 0x$red)
green=$(printf "%d\n" 0x$green)
blue=$(printf "%d\n" 0x$blue)

echo $(expr "$red" \* 0.299 + "$green" \* 0.587 + "$blue" \* 0.114)

