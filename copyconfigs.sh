#!/bin/bash
# ---
# USAGE:
# ./copyconfigs.sh $username
# ---
# This file copies Arch/i3 configuration files from this current user to the passed user

# Check if username is provided
if [ -z "$1" ]; then
  echo "Error: No username provided. Usage: ./script.sh <username>"
  exit 1
fi

USERNAME=$1
HOME_DIR=/home/$USERNAME

# Check if user exists
if ! id "$USERNAME" &>/dev/null; then
  echo "Error: User $USERNAME does not exist."
  exit 1
fi

# Create .config directory if it doesn't exist
sudo mkdir -p $HOME_DIR/.config

# Copy .config directory
sudo cp -r ~/.config $HOME_DIR/

# Copy additional configuration files
sudo cp ~/.bashrc $HOME_DIR/
sudo cp ~/.nanorc $HOME_DIR/
sudo cp ~/.Xresources $HOME_DIR/

# Fix ownership
sudo chown -R $USERNAME:$USERNAME $HOME_DIR/.config
sudo chown $USERNAME:$USERNAME $HOME_DIR/.bashrc
sudo chown $USERNAME:$USERNAME $HOME_DIR/.nanorc
sudo chown $USERNAME:$USERNAME $HOME_DIR/.Xresources

# Ensure .xinitrc exists and is executable
if [ ! -f $HOME_DIR/.xinitrc ]; then
  echo "exec i3" | sudo tee $HOME_DIR/.xinitrc > /dev/null
  sudo chmod +x $HOME_DIR/.xinitrc
  sudo chown $USERNAME:$USERNAME $HOME_DIR/.xinitrc
fi

echo "Configuration transfer completed for user $USERNAME."
