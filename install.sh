#!/bin/bash

echo "Installing .dotfiles..."

echo "Linking .gitconfig..."
ln -fs ~/.dotfiles/.gitconfig ~/.gitconfig

echo "Linking .zshrc..."
ln -fs ~/.dotfiles/.zshrc ~/.zshrc

echo "Linking i3..."
mkdir -p ~/.config/i3/
ln -fs ~/.dotfiles/i3 ~/.config/i3/config

echo "Linking picom..."
mkdir -p ~/.config/picom/
ln -fs ~/.dotfiles/picom.conf ~/.config/picom/picom.conf

echo "Linking rofi..."
mkdir -p ~/.config/rofi/
ln -fs ~/.dotfiles/rofi.rasi ~/.config/rofi/config.rasi

echo "Linking polybar..."
mkdir -p ~/.config/polybar/
ln -fs ~/.dotfiles/polybar.ini ~/.config/polybar/config.ini

echo "Linking polybar launch..."
ln -fs ~/.dotfiles/launch-polybar.sh ~/.config/polybar/launch.sh

echo "Linking emacs..."
mkdir -p ~/.emacs.d/
ln -fs ~/.dotfiles/init.el ~/.emacs.d/init.el

echo "Linking dunstrc ..."
mkdir -p ~/.config/dunst/
ln -fs ~/.dotfiles/dunstrc ~/.config/dunst/dunstrc

echo "Done."
