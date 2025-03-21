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
sudo pacman -S --needed iwd vi nano git less xdotool nodejs npm ttf-liberation noto-fonts noto-fonts-emoji ttf-dejavu pango rofi rofimoji flameshot brightnessctl redshift jq unzip tmux xsel nodejs npm

# Configure git
git config --global init.defaultBranch main

# Swap CAPSLOCK with ESC
touch /etc/udev/rules.d/99-keyboard-remap.rules
chmod +x /etc/udev/rules.d/99-keyboard-remap.rules
sudo tee /etc/udev/rules.d/99-keyboard-remap.rules << 'EOF'
ACTION=="add", SUBSYSTEM=="input", ATTRS{name}=="*[Kk]eyboard*", RUN+="/bin/sh -c 'sleep 1; DISPLAY=:0 setxkbmap -option caps:swapescape'", TAG+="uaccess"
EOF

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

# Configs, fonts, emojis
cp -r .config ~
fc-cache -fv

# Permissions
sudo usermod -aG video $USER
