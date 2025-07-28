#!/bin/bash
# nohup /sgoinfre/goinfre/Perso/mochamsa/troll/monitor.sh > /dev/null 2>&1 &
# if ! grep -q "/sgoinfre/goinfre/Perso/mochamsa/troll/uwusound.sh" ~/.zshrc 2>/dev/null; then
#     cat << EOF >> ~/.zshrc
# nohup /sgoinfre/goinfre/Perso/mochamsa/troll/uwusound.sh > /dev/null 2>&1 &
# EOF
# fi

XDOTOOL_PATH="/sgoinfre/goinfre/Perso/mochamsa/utils/xdotool_temp/usr/bin/xdotool"
export LD_LIBRARY_PATH="/sgoinfre/goinfre/Perso/mochamsa/utils/xdotool_temp/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH"

if [ ! -d ~/.config/sxhkd ]; then
    mkdir -p ~/.config/sxhkd
fi
cat > ~/.config/sxhkd/sxhkdrc << EOF
space
    paplay /sgoinfre/goinfre/Perso/mochamsa/wav/uwuwu.wav
control + d
    paplay /sgoinfre/goinfre/Perso/mochamsa/wav/prout.wav
control + c
    paplay /sgoinfre/goinfre/Perso/mochamsa/wav/AHHH.wav
control + j
    pkill sxhkd 
Return
    paplay /sgoinfre/goinfre/Perso/mochamsa/wav/tarpin.wav
KP_Enter
    paplay /sgoinfre/goinfre/Perso/mochamsa/wav/tarpin.wav
EOF
/sgoinfre/goinfre/Perso/mochamsa/utils/sxhkd_temp/usr/bin/sxhkd &
/sgoinfre/goinfre/Perso/mochamsa/troll/sound-lock.sh &
