#!/data/data/com.termux/files/usr/bin/bash
# Termux Setup Script for ScanMaster by [YOUR FULL NAME HERE]

PROJECT_DIR=$(pwd)
TOOL_NAME="Ghost-Rid3r"
PYTHON_BIN="python"

echo "[+] Starting Termux Setup for $TOOL_NAME (Android/Termux)..."

# 1. Update Termux packages and install Python
echo "[*] Ensuring Python and basic tools are installed..."
pkg update -y
pkg install -y python git openssh

# 2. Install Python dependencies (from requirements.txt)
echo "[*] Installing Python dependencies..."
$PYTHON_BIN -m pip install -r $PROJECT_DIR/requirements.txt

# 3. Make the core script executable
echo "[*] Setting file permissions..."
chmod +x $PROJECT_DIR/$TOOL_NAME.py

# 4. Create a permanent alias in the Termux environment
PROFILE_FILE="$HOME/.bashrc"
ALIAS_CMD="alias $TOOL_NAME='$PYTHON_BIN $PROJECT_DIR/$TOOL_NAME.py'"

if grep -q "$ALIAS_CMD" "$PROFILE_FILE"; then
    echo "[*] Alias for $TOOL_NAME already exists."
else
    echo -e "\n# ScanMaster CLI Alias (by [Ghost-Rid3r])" >> "$PROFILE_FILE"
    echo "$ALIAS_CMD" >> "$PROFILE_FILE"
    echo "[+] Alias created! Run 'source $PROFILE_FILE' or restart Termux to use the '$TOOL_NAME' command."
fi

echo "[+] Setup Complete. To run, type: $TOOL_NAME scan 127.0.0.1"