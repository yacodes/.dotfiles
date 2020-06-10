#!/bin/bash

echo "Linking .gitconfig..."
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig

echo "Linking .zshrc..."
ln -s ~/.dotfiles/.zshrc ~/.zshrc

echo "Linking .spacemacs..."
ln -s ~/.dotfiles/.spacemacs ~/.spacemacs

echo "Done."
