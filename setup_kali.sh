#!/bin/bash
# Kali/Linux Setup Script for ScanMaster by [YOUR FULL NAME HERE]

PROJECT_DIR=$(pwd)
TOOL_NAME="scanmaster"
PYTHON_BIN="python3"

echo "[+] Starting Kali/Linux Setup for $TOOL_NAME..."

# 1. Update and ensure Python3 and pip are installed
echo "[*] Ensuring Python3 and pip are installed..."
sudo apt update -y
sudo apt install -y python3 python3-pip

# 2. Install Python dependencies (from requirements.txt)
echo "[*] Installing Python dependencies..."
$PYTHON_BIN -m pip install -r $PROJECT_DIR/requirements.txt

# 3. Make the core script executable
echo "[*] Setting file permissions..."
chmod +x $PROJECT_DIR/$TOOL_NAME.py

# 4. Create a permanent alias in the user's shell profile (.bashrc or .zshrc)
PROFILE_FILE=""
if [ -f "$HOME/.zshrc" ]; then
    PROFILE_FILE="$HOME/.zshrc"
elif [ -f "$HOME/.bashrc" ]; then
    PROFILE_FILE="$HOME/.bashrc"
fi

if [ -n "$PROFILE_FILE" ]; then
    ALIAS_CMD="alias $TOOL_NAME='$PYTHON_BIN $PROJECT_DIR/$TOOL_NAME.py'"
    if grep -q "$ALIAS_CMD" "$PROFILE_FILE"; then
        echo "[*] Alias for $TOOL_NAME already exists."
    else
        echo -e "\n# ScanMaster CLI Alias (by [YOUR FULL NAME HERE])" >> "$PROFILE_FILE"
        echo "$ALIAS_CMD" >> "$PROFILE_FILE"
        echo "[+] Alias created! Run 'source $PROFILE_FILE' or start a new terminal to use the '$TOOL_NAME' command."
    fi
else
    echo "[-] Warning: Could not find .bashrc or .zshrc. Please run the tool directly: $PYTHON_BIN $PROJECT_DIR/$TOOL_NAME.py"
fi

echo "[+] Setup Complete. To run, type: $TOOL_NAME scan 192.168.1.1"