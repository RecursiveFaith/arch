#!/bin/bash
cp -r ~/.config/i3 .config
cp -r ~/.config/i3status .config
cp -r ~/.config/fontconfig .config
cp -r ~/.config/rofi .config

cp -r ~/.vim .
rm .vim/.netrwhist

# Copy additional configuration files
cp ~/.bashrc .
cp ~/.nanorc .
cp ~/.vimrc .
cp ~/.tmux.conf .
cp ~/.Xresources .
