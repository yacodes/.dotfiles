#!/bin/bash

echo "Linking nvim configuration..."
mkdir -p ~/.config/nvim
ln -s ~/.dotfiles/nvim/init.vim ~/.config/nvim/init.vim

echo "Linking tmux configutation..."
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf

echo "Linking .gitconfig..."
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig

echo "Linking .zshrc..."
ln -s ~/.dotfiles/.zshrc ~/.zshrc

echo "Linking alacritty.yml..."
ln -s ~/.dotfiles/alacritty.yml ~/.config/alacritty/alacritty.yml

echo "Linking .spacemacs..."
ln -s ~/.dotfiles/.spacemacs ~/.spacemacs

echo "Done."
