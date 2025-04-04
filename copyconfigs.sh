#!/bin/bash
# ---
# USAGE:
# ./copyconfigs.sh [username]
# ---
# This file copies Arch/i3 configuration files from this current user to the passed user.
# If no username is provided, it defaults to the current user ($USER).

# Set USERNAME: use $1 if provided, otherwise default to the current user ($USER)
USERNAME="${1:-$USER}"

HOME_DIR="/home/$USERNAME"

# Check if the target user exists
if ! id "$USERNAME" &>/dev/null; then
  echo "Error: User $USERNAME does not exist."
  exit 1
fi

# Create .config directory if it doesn't exist
mkdir -p "$HOME_DIR/.config"

# Copy .config directory
cp -r .config "$HOME_DIR/"
cp -r .vim "$HOME_DIR/"

# Copy additional configuration files
cp .bashrc "$HOME_DIR/"
cp .bash_profile "$HOME_DIR/"
cp .nanorc "$HOME_DIR/"
cp .vimrc "$HOME_DIR/"
cp .tmux.conf "$HOME_DIR/"
cp .Xresources "$HOME_DIR/"

# Ensure .xinitrc exists and is executable
if [ ! -f "$HOME_DIR/.xinitrc" ]; then
  echo "exec i3" | sudo tee "$HOME_DIR/.xinitrc" > /dev/null
  chmod +x "$HOME_DIR/.xinitrc"
  chown "$USERNAME:$USERNAME" "$HOME_DIR/.xinitrc"
fi

echo "Configuration transfer completed for user $USERNAME."
