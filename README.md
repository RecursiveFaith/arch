# Arch Setup Instructions

This document consolidates all the steps for installing Arch Linux with your preferred configurations including i3, fonts, rofi, and more. Follow the steps in order.

---

## 1. Arch Installer

1. Use Ventoy to create a bootable USB.
2. Boot from the USB and run the following commands:

```sh
# Zero out the drive (replace "nvme0n1" with your actual drive as seen with lsblk)
lsblk -o NAME,SIZE,MODEL
dd if=/dev/urandom of=/dev/nvme0n1 bs=4M status=progress

# Start the Arch installer (DO NOT PICK A MIRROR to avoid potential time sync issues)
archinstall
```

---

## 2. Package Installation

Install all required packages in one command:

```sh
sudo pacman -S iwd vi nano git less xdotool nodejs npm flameshot brightnessctl redshift ttf-liberation noto-fonts noto-fonts-emoji ttf-dejavu pango rofi rofimoji xorg-xset
```

---

## 3. Configuration Files

### 3.1. i3 Window Manager & i3status

Save the following i3 configuration to `~/.config/i3/config`:

```sh
# Swap ESC with CapsLock
exec --no-startup-id setxkbmap -option caps:swapescape

# Merge Xresources for DPI settings (Make sure ~/.Xresources is configured)
exec --no-startup-id xrdb -merge ~/.Xresources

# Rofi keybindings
bindsym $mod+d exec --no-startup-id rofi -show drun
bindsym $mod+period exec --no-startup-id rofimoji

# Screenshot keybindings
bindsym Print exec flameshot gui        # Full GUI interface on PrtScrn
bindsym Shift+Print exec flameshot gui -s  # Direct region selection

# Brightness controls
bindsym XF86MonBrightnessUp exec brightnessctl s +10%
bindsym XF86MonBrightnessDown exec brightnessctl s 10%-

# Redshift configuration (update latitude/longitude if needed)
exec --no-startup-id redshift -l 45.523064:-122.676483 -t 6500:3000

# Screen lock (DPMS timeout: 20 minutes => 1200 seconds)
exec --no-startup-id xset dpms 0 0 1200

# i3bar configuration with custom colors
bar {
  status_command i3status
  colors {
      background #050f0e
      separator  #FF1342
      focused_workspace  #FF1342 #FF1342 #ffffff
      inactive_workspace #062621 #062621 #12FFBC
      urgent_workspace   #ffc826 #ffc826 #050f0e
  }
}

# Window border colors
client.focused          #FF1342 #FF1342 #ffffff #FF1342 #FF1342
client.unfocused        #050f0e #050f0e #3D996B   #FF1342 #050f0e
client.focused_inactive #333333 #5f676a #ffffff #484e50 #5f676a
client.urgent           #ffc826 #ffc826 #050f0e   #ffc826 #ffc826
client.placeholder      #000000 #0c0c0c #ffffff   #000000 #0c0c0c
```

Next, set up i3status by creating or updating `~/.config/i3status/config`:

```sh
mkdir -p ~/.config/i3status
cp /etc/i3status.conf ~/.config/i3status/config
```

Then append or update the configuration with:

```sh
general {
    colors = true
    interval = 5
    color_good = "#12FFBC"
    color_degraded = "#ffc826"
    color_bad = "#FF1342"
    separator = " | "
}
```

---

### 3.2. Fonts and Xresources

**Xresources** – create or update `~/.Xresources` with:

```sh
Xft.dpi: 192
xterm*faceName: DejaVu Sans Mono:size=10
xterm*background: #050f0e
xterm*foreground: #ffffff
```

Merge the changes:

```sh
xrdb -merge ~/.Xresources
```

**Fonts** – create or update your font configuration at `~/.config/fontconfig/fonts.conf`:

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

**Rofi** – dump the default rofi configuration for customization:

```sh
mkdir -p ~/.config/rofi
rofi -dump-config > ~/.config/rofi/config.rasi
```

---

### 3.3. Touchpad Configuration

Create a touchpad configuration file at `/etc/X11/xorg.conf.d/30-touchpad.conf` (using your preferred editor, e.g., sudo nano):

```sh
Section "InputClass"
    Identifier "touchpad"
    Driver "libinput"
    MatchIsTouchpad "on"
    Option "Tapping" "on"
    Option "TapButton2" "2"  # Two-finger tap for right-click
    Option "TapButton3" "3"  # Three-finger tap for middle-click
EndSection
```

---

## 4. Additional Configurations

### 4.1. Bash Configuration

Add the following to your `~/.bashrc`:

```sh
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

---

### 4.2. Nano Configuration

Create or update `~/.nanorc` to include markdown syntax highlighting:

```sh
include "/usr/share/nano/markdown.nanorc"
```

---

### 4.3. HDMI Audio Setup

1. List sinks to find your HDMI device:

   ```sh
   pactl list sinks | grep Name
   ```

2. Set the HDMI sink as the default (replace `` with the correct identifier):

   ```sh
   pactl set-default-sink 
   ```

---

### 4.4. Permissions for Brightness Control

Add your user (and any additional users such as "sandbox") to the video group:

```sh
sudo usermod -aG video $USER
sudo usermod -aG video sandbox
```

---

## 5. Final Notes

- After making changes to configuration files, restart i3 (for example, use the SHIFT+META+R keybinding) or log out/in.
- Update coordinates in the redshift command if needed.
- Always double-check drive names using `lsblk` before running any destructive commands.
- Customize values (such as DPI, colors, and command options) to suit your preferences.
