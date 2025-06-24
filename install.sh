#!/usr/bin/env sh

echo "Installing .dotfiles..."

echo "Linking .gitconfig..."
ln -fs ~/.dotfiles/.gitconfig ~/.gitconfig

echo "Linking .zshrc..."
ln -fs ~/.dotfiles/.zshrc ~/.zshrc

echo "Linking i3..."
mkdir -p ~/.config/i3/
ln -fs ~/.dotfiles/i3 ~/.config/i3/config

echo "Linking rofi..."
mkdir -p ~/.config/rofi/
ln -fs ~/.dotfiles/rofi.rasi ~/.config/rofi/config.rasi

echo "Linking emacs..."
mkdir -p ~/.emacs.d/
ln -fs ~/.dotfiles/init.el ~/.emacs.d/init.el

echo "Linking dunstrc..."
mkdir -p ~/.config/dunst/
ln -fs ~/.dotfiles/dunstrc ~/.config/dunst/dunstrc

echo "Linking picom configuration…"
ln -fs ~/.dotfiles/picom.conf ~/.config/picom.conf

echo "Linking atuin configuration…"
mkdir -p ~/.config/atuin/
ln -fs ~/.dotfiles/atuin.toml ~/.config/atuin/config.toml

echo "Linking XOrg configration…"
ln -fs ~/.dotfiles/.xbindkeysrc ~/.xbindkeysrc
ln -fs ~/.dotfiles/.Xresources ~/.Xresources
ln -fs ~/.dotfiles/.Xmodmap ~/.Xmodmap
ln -fs ~/.dotfiles/.xinitrc ~/.xinitrc

echo "Done."
