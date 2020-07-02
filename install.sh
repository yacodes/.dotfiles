#!/bin/bash

echo "Installing .dotfiles..."

echo "Linking .gitconfig..."
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig

echo "Linking .zshrc..."
ln -s ~/.dotfiles/.zshrc ~/.zshrc

echo "Linking i3..."
mkdir -p ~/.config/i3/
ln -s ~/.dotfiles/i3 ~/.config/i3/config

echo "Linking picom..."
mkdir -p ~/.config/picom/
ln -s ~/.dotfiles/picom.conf ~/.config/picom/picom.conf

echo "Linking rofi..."
mkdir -p ~/.config/rofi/
ln -s ~/.dotfiles/rofi.rasi ~/.config/rofi/config.rasi

echo "Linking polybar..."
mkdir -p ~/.config/polybar/
ln -s ~/.dotfiles/polybar.ini ~/.config/polybar/config.ini

echo "Linking emacs..."
mkdir -p ~/.emacs.d/
ln -s ~/.dotfiles/init.el ~/.emacs.d/init.el

echo "Done."
