#!/usr/bin/env bash

# Exit on any error
set -e

# Ensure we are on Arch Linux
if [[ ! -f /etc/arch-release ]]; then
    echo "Error: This script is only for Arch Linux."
    exit 1
fi

echo "Updating system..."
sudo pacman -Syu --noconfirm

# Install essential packages
echo "Installing essential packages: git, base-devel, zsh..."
sudo pacman -S --noconfirm --needed git base-devel zsh

# Create standard home directories
echo "Creating home directories..."
for dir in .config Downloads Scripts Software; do
    mkdir -p "$HOME/$dir"
done

# Change default shell to zsh if not already
if [[ "$SHELL" != "$(which zsh)" ]]; then
    echo "Changing default shell to zsh..."
    sudo chsh -s "$(which zsh)" "$USER"
fi

# Clone dotfiles early to use pkglist.txt
DOTFILES="$HOME/.dotfiles"
if [[ ! -d "$DOTFILES" ]]; then
    echo "Cloning dotfiles..."
    git clone https://github.com/itzDJ/.dotfiles "$DOTFILES"
fi

# Install packages from pkglist.txt
if [[ -f "$DOTFILES/pkglist.txt" ]]; then
    echo "Installing packages from pkglist.txt..."
    sudo pacman -S --noconfirm --needed - < "$DOTFILES/pkglist.txt"
fi

# Install Brave browser from AUR
BRAVE_DIR="$HOME/Software/brave-bin"
if [[ ! -d "$BRAVE_DIR" ]]; then
    echo "Cloning Brave AUR package..."
    git clone https://aur.archlinux.org/brave-bin.git "$BRAVE_DIR"
fi
echo "Building and installing Brave..."
makepkg -si --noconfirm -D "$BRAVE_DIR"

# Symlink dotfiles
echo "Creating symlinks for configuration..."
ln -sf "$DOTFILES/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES/.zprofile" "$HOME/.zprofile"
ln -sf "$DOTFILES/.config/hypr" "$HOME/.config/hypr"
ln -sf "$DOTFILES/.config/waybar" "$HOME/.config/waybar"

# Install Neovim configuration
NVIM_CONFIG="$HOME/.config/nvim"
if [[ ! -d "$NVIM_CONFIG" ]]; then
    echo "Cloning Neovim config..."
    git clone https://github.com/itzDJ/nvim "$NVIM_CONFIG"
fi

echo ""
echo "Setup complete!"
echo "Please log out and log back in to apply changes."
