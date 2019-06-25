#!/bin/bash

echo "Linking nvim configuration..."
mkdir -p ~/.config/nvim
ln -sf ~/.dotfiles/nvim/init.vim ~/.config/nvim/init.vim

echo "Linking tmux configutation..."
ln -sf ~/.dotfiles/.tmux.conf ~/.tmux.conf

echo "Done."
