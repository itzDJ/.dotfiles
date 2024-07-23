#!/bin/bash

# Script needed since I'm not using a git bare repo or stow

cd $HOME
git clone https://github.com/itzDJ/.dotfiles
cd .dotfiles

# General configs
cp ~/.zshrc ~/.dotfiles/.zshrc
cp ~/.config/alacritty/alacritty.toml ~/.dotfiles/alacritty.toml

# OS specific configs
if [[ "$OSTYPE" == "darwin"* ]]; then
    printf "MacOS detected\n"
    # Create a Brewfile (all installed packages)
    brew bundle dump
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
    printf "Linux detected; Arch assumed\n"
    # Removing unused packages (orphans)
    yay -Qdtq | ifne yay -Rns -
    # Creates a file with all explicitly installed packages
    yay -Qqe > arch_packages.txt

    cp -r ~/.config/hypr ~/.dotfiles
    cp -r ~/.config/waybar ~/.dotfiles
    cp -r ~/.config/wofi ~/.dotfiles
else
    printf "OS not supported. Exiting...\n"
    exit 1
fi

printf ".dotfiles updated. Commit and push manually\n"
