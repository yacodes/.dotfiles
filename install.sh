#!/bin/bash

echo "Linking nvim configuration..."
mkdir -p ~/.config/nvim
ln -s ~/.dotfiles/nvim/init.vim ~/.config/nvim/init.vim
