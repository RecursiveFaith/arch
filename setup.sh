#!/bin/bash
# ---
# USAGE:
# ./setup.sh
# ---
# This file partially automates the instructions in README.md
# Features:
# - Install packages
# - Configure git (current user only)
# - swaps CAPSLOCK with ESC

# Install all packages at once
sudo pacman -S --needed iwd vi nano git less xdotool nodejs npm ttf-liberation noto-fonts noto-fonts-emoji ttf-dejavu pango rofi rofimoji flameshot brightnessctl redshift jq unzip tmux xsel nodejs npm make gawk tree

# Configure git
git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global submodule.recurse true

# Touchpad
sudo touch /etc/X11/xorg.conf.d/30-touchpad.conf
sudo tee /etc/X11/xorg.conf.d/30-touchpad.conf << 'EOF'
Section "InputClass"
    Identifier "touchpad"
    Driver "libinput"
    MatchIsTouchpad "on"
    Option "Tapping" "on"
    Option "TapButton2" "2"  # Two-finger tap for right-click
    Option "TapButton3" "3"  # Three-finger tap for middle-click
EndSection
EOF

# Display
cp .Xresources ~
xrdb -merge ~/.Xresources

# Install blesh
if [ ! -d ~/.local/share/blesh ]; then
  git clone --recursive --depth 1 https://github.com/akinomyoga/ble.sh.git
  make -C ble.sh install PREFIX=~/.local
  rm -rf ble.sh 
fi

# Configs, fonts, emojis
source ~/.bashrc
./copyconfigs.sh $USER
fc-cache -fv

# Permissions
sudo usermod -aG video $USER

# Ollama
if ! command -v ollama >/dev/null; then
  curl -fsSL https://ollama.com/install.sh | sh
  ollama pull deepseek-r1:1.5b
  ollama pull granite3.2-vision
  ollama pull granite3.2:2b
  ollama pull gemma3:4b
  ollama pull phi4-mini
fi
