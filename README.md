# Arch Linux Setup Instructions

## 1. Initial Installation

```sh
# Use Ventoy to create an install USB
# After rebooting into the USB:

# Zero drive; first get drive like "nvme0n1"
lsblk -o NAME,SIZE,MODEL
dd if=/dev/urandom of=/dev/nvme0n1 bs=4M status=progress

# Install (DO NOT PICK A MIRROR or you could get time sync issues as of 250317)
archinstall
```

## 2. Package Installation

```sh
# Install all packages at once
sudo pacman -S iwd vi nano git less xdotool nodejs npm ttf-liberation noto-fonts noto-fonts-emoji ttf-dejavu pango rofi rofimoji flameshot brightnessctl redshift
```

## 3. Git Configuration

```sh
git config --global init.defaultBranch main
```

## 4. System Configurations

### Touchpad Configuration

```sh
sudo nano /etc/X11/xorg.conf.d/30-touchpad.conf
```

Add this to the file:
```
Section "InputClass"
    Identifier "touchpad"
    Driver "libinput"
    MatchIsTouchpad "on"
    Option "Tapping" "on"
    Option "TapButton2" "2"  # Two-finger tap for right-click
    Option "TapButton3" "3"  # Three-finger tap for middle-click
EndSection
```

### Display and Appearance Configuration

Create/edit `~/.Xresources`:
```
Xft.dpi: 192
xterm*faceName: DejaVu Sans Mono:size=10
xterm*background: #050f0e
xterm*foreground: #ffffff
```

Apply the changes:
```sh
xrdb -merge ~/.Xresources
```

### Font Configuration

Create the font configuration directory and file:
```sh
mkdir -p ~/.config/fontconfig
```

Edit `~/.config/fontconfig/fonts.conf`:
```xml
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <alias>
    <family>sans-serif</family>
    <prefer>
      <family>Noto Sans</family>
      <family>Noto Color Emoji</family>
    </prefer>
  </alias>
  <alias>
    <family>monospace</family>
    <prefer>
      <family>Noto Mono</family>
      <family>Noto Color Emoji</family>
    </prefer>
  </alias>
</fontconfig>
```

Refresh fonts:
```sh
fc-cache -fv
```

### i3 Configuration

Create/edit `~/.config/i3/config` and add these entries:

```
# Key swap (add at top of file)
exec --no-startup-id setxkbmap -option caps:swapescape

# Rofi bindings
bindsym $mod+d exec --no-startup-id rofi -show drun
bindsym $mod+period rofimoji

# Screenshot bindings
bindsym Print exec flameshot gui  # Full GUI interface on PrtScrn
bindsym Shift+Print exec flameshot gui -s  # Direct region selection

# Brightness controls
bindsym XF86MonBrightnessUp exec brightnessctl s +10%
bindsym XF86MonBrightnessDown exec brightnessctl s 10%-

# Redshift for eye comfort
exec --no-startup-id redshift -l 45.523064:-122.676483 -t 6500:3000

# Screen timeout
exec --no-startup-id xset dpms 0 0 1200

# i3bar configuration
# Start i3bar to display a workspace bar (plus the system information i3status
# finds out, if available)
bar {
  status_command i3status

  colors {
      background #050f0e
      separator #FF1342
      focused_workspace #FF1342 #FF1342 #ffffff
      inactive_workspace #062621 #062621 #12FFBC
      urgent_workspace #ffc826 #ffc826 #050f0e
  }
}

# Window Colors
# Inspiration: https://marketplace.visualstudio.com/items?itemName=TheEdgesofBen.punk-runner

                        # border, bg, text, indicator, child_border
client.focused          #FF1342 #FF1342 #ffffff #FF1342 #FF1342
client.unfocused        #050f0e #050f0e #3D996B #FF1342 #050f0e
client.focused_inactive #333333 #5f676a #ffffff #484e50 #5f676a
client.urgent           #ffc826 #ffc826 #050f0e #ffc826 #ffc826
client.placeholder      #000000 #0c0c0c #ffffff #000000 #0c0c0c
```

Then uncomment the dmenu binding: `# bindsym $mod+d exec --no-startup-id dmenu_ru`

### i3status Configuration

```sh
mkdir -p ~/.config/i3status
cp /etc/i3status.conf ~/.config/i3status/config
```

Edit `~/.config/i3status/config` to add:
```
general {
        colors = true
        interval = 5
        color_good = "#12FFBC"
        color_degraded = "#ffc826"
        color_bad = "#FF1342"
        separator = " | "
}
```

### Rofi Setup

```sh
mkdir -p ~/.config/rofi
rofi -dump-config > ~/.config/rofi/config.rasi

# Create symlink from dmenu to rofi
sudo ln -s /usr/bin/rofi /usr/bin/dmenu
```

### User Group Permissions

```sh
# Add user to video group for brightness control
sudo usermod -aG video $USER
sudo usermod -aG video sandbox
```

## 5. Shell Configurations

### Bash Configuration

Edit `~/.bashrc`:
```sh
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

alias browser='brave --force-device-scale-factor=1.6 &'
alias vi='vim'

export HEY_BASE="$HOME/github/oz/hey.sh"
export HEY_GIT="$HOME/github/oz/dailies"
export HEY_MODEL='google/gemini-2.0-flash-001'
export API_OPENROUTER='sk-or-v1-'
alias save="$HOME/github/oz/hey.sh/bot/git"
alias chat="$HOME/github/oz/hey.sh/chat"
alias sshadd="eval $(ssh-agent); ssh-add"
```

### Nano Configuration

Create/edit `~/.nanorc`:
```
set mouse
set softwrap
set atblanks
include "/usr/share/nano/markdown.nanorc"
```

## 6. Audio Configuration

Check and set HDMI audio:
```sh
# List your sinks
pactl list sinks

# Set the default sink to HDMI
pactl set-default-sink 
```
