# Arch Linux Setup Instructions

## Initial Installation

```sh
# Use Ventoy to create an install USB
# After rebooting into the USB:

# Zero drive; first get drive like "nvme0n1"
lsblk -o NAME,SIZE,MODEL
dd if=/dev/urandom of=/dev/nvme0n1 bs=4M status=progress

# Install (DO NOT PICK A MIRROR or you could get time sync issues as of 250317)
archinstall
```

## Post install
Run `./setup.sh` to run the post install scripts, which include:
- Display and theming
- Fonts and emojis
- Swap CAPSLOCK with ESC
- Touchpad
- Other packages:
  - Screenshots
  - Emoji picker
  - Brightness and blue light filters
  - Coding tools
- Adds ble.sh with autocomplete and syntax highlighting for Bash
- i3 improvements
  - vim navigation bindings
  - integration with tmux

## API keys
To setup your API keys, run the following:

```bash
# OPENROUTER.ai
sudo touch /etc/profile.d/openrouter.sh
sudo chmod 644 /etc/profile.d/openrouter.sh
echo 'export API_OPENROUTER="your_api_key"' | sudo tee /etc/profile.d/openrouter.sh > /dev/null 
```

Then restart your machine to apply API keys globally to all users

## HDMI/External Audio Configuration
To configure external audio, try the following:

```sh
# List your sinks
pactl list sinks

# Set the default sink to HDMI ID #
pactl set-default-sink 
```
