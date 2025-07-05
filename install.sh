#!/usr/bin/env bash

# Exit on error
set -e

# Exit if system isn't running archlinux
if [[ ! -f /etc/arch-release ]]; then
    echo "Error: Failed to detect /etc/arch-release"
    exit 1
fi

# Make sure cwd=$HOME
cd $HOME

# Update system
sudo pacman -Syu --noconfirm

# Install AUR helper
sudo pacman -S --needed --noconfirm git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay

# Zsh setup
sudo pacman -S --needed --noconfirm zsh
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# OS setup
sudo pacman -S --needed --noconfirm neovim ghostty hyprland unzip npm pyenv
pyenv install 3
pyenv global 3

# Dotfiles symlinks
git clone https://github.com/itzDJ/.dotfiles
cd .dotfiles
# WIP
