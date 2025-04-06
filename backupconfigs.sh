#!/bin/bash
cp -r ~/.config/i3 $ARCH/.config
cp -r ~/.config/i3status $ARCH/.config
cp -r ~/.config/fontconfig $ARCH/.config
cp -r ~/.config/rofi $ARCH/.config

cp -r ~/.vim $ARCH
rm .vim/.netrwhist

# Copy additional configuration files
cp ~/.bashrc $ARCH
cp ~/.bash_profile $ARCH
cp ~/.nanorc $ARCH
cp ~/.vimrc $ARCH
cp ~/.tmux.conf $ARCH
cp ~/.Xresources $ARCH
