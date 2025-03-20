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
sudo pacman -S --needed iwd vi nano git less xdotool nodejs npm ttf-liberation noto-fonts noto-fonts-emoji ttf-dejavu pango rofi rofimoji flameshot brightnessctl redshift jq unzip tmux xsel

# Configure git
git config --global init.defaultBranch main

# Swap CAPSLOCK with ESC
touch /etc/udev/rules.d/99-keyboard-remap.rules
chmod +x /etc/udev/rules.d/99-keyboard-remap.rules
sudo tee /etc/udev/rules.d/99-keyboard-remap.rules << 'EOF'
ACTION=="add", SUBSYSTEM=="input", ATTRS{name}=="*[Kk]eyboard*", RUN+="/bin/sh -c 'sleep 1; DISPLAY=:0 setxkbmap -option caps:swapescape'", TAG+="uaccess"
EOF
