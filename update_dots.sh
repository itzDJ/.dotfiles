#!/bin/bash

# Script needed since I'm not using a git bare repo or stow

rm -rf ~/.dotfiles
cd $HOME
git clone https://github.com/itzDJ/.dotfiles
cd .dotfiles

# General configs
cp ~/.zshrc ~/.dotfiles/mac/.zshrc
cp ~/.config/alacritty/alacritty.toml ~/.dotfiles/mac/alacritty.toml

# OS specific configs
if [[ "$OSTYPE" == "darwin"* ]]; then
    printf "MacOS detected\n"
    # Create a Brewfile (all installed packages)
    brew bundle dump
    mv Brewfile ~/.dotfiles/mac

    cp ~/.config/aerospace/aerospace.toml ~/.dotfiles/mac/aerospace.toml
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
    printf "Linux detected; Arch assumed\n"
    # Removing unused packages (orphans)
    yay -Qdtq | ifne yay -Rns -
    # Creates a file with all explicitly installed packages
    yay -Qqe > arch_packages.txt
    mv arch_packages.txt ~/.dotfiles/arch

    cp ~/.zprofile ~/.dotfiles/arch/.zprofile

    cp -r ~/.config/hypr ~/.dotfiles/arch
    cp -r ~/.config/waybar ~/.dotfiles/arch
    cp -r ~/.config/wofi ~/.dotfiles/arch

    cp ~/.config/neofetch/config.conf ~/.dotfiles/arch/neofetch.conf
else
    printf "OS not supported. Exiting...\n"
    exit 1
fi

printf ".dotfiles updated. Commit and push manually\n"
