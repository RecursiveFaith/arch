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
sudo mkdir -p "$HOME_DIR/.config"

# Copy .config directory
sudo cp -r .config "$HOME_DIR/"
sudo cp -r .vim "$HOME_DIR/"

# Copy additional configuration files
sudo cp .bashrc "$HOME_DIR/"
sudo cp .nanorc "$HOME_DIR/"
sudo cp .vimrc "$HOME_DIR/"
sudo cp .tmux.conf "$HOME_DIR/"
sudo cp .Xresources "$HOME_DIR/"

# Fix ownership
sudo chown -R "$USERNAME:$USERNAME" "$HOME_DIR/.config"
sudo chown -R "$USERNAME:$USERNAME" "$HOME_DIR/.vim"
sudo chown "$USERNAME:$USERNAME" "$HOME_DIR/.bashrc"
sudo chown "$USERNAME:$USERNAME" "$HOME_DIR/.nanorc"
sudo chown "$USERNAME:$USERNAME" "$HOME_DIR/.vimrc"
sudo chown "$USERNAME:$USERNAME" "$HOME_DIR/.tmux.conf"
sudo chown "$USERNAME:$USERNAME" "$HOME_DIR/.Xresources"

# Ensure .xinitrc exists and is executable
if [ ! -f "$HOME_DIR/.xinitrc" ]; then
  echo "exec i3" | sudo tee "$HOME_DIR/.xinitrc" > /dev/null
  sudo chmod +x "$HOME_DIR/.xinitrc"
  sudo chown "$USERNAME:$USERNAME" "$HOME_DIR/.xinitrc"
fi

echo "Configuration transfer completed for user $USERNAME."

    
