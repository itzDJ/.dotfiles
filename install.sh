#!/usr/bin/env bash
set -euo pipefail

# Checks
[[ -f /etc/arch-release ]] || { echo "Error: Arch Linux only."; exit 1; }
[[ "$EUID" -ne 0 ]]        || { echo "Error: Do not run as root."; exit 1; }

# Variables
DOTFILES="$HOME/.dotfiles"

PACMAN_PACKAGES=(
    dolphin
    fastfetch
    ghostty
    htop
    hyprland
    hyprlauncher
    hyprlock
    man-db
    neovim
    npm
    pavucontrol
    python
    ripgrep
    ttf-jetbrains-mono-nerd
    unzip
    waybar
    zsh
    zsh-syntax-highlighting
)

AUR_PACKAGES=(
    brave-bin
    mullvad-vpn-bin
)

# System update and base packages
echo "Updating system..."
sudo pacman -Syu --noconfirm

echo "Installing base dependencies..."
sudo pacman -S --noconfirm --needed git base-devel

# Dotfiles
if [[ ! -d "$DOTFILES" ]]; then
    echo "Cloning dotfiles..."
    git clone https://github.com/itzDJ/.dotfiles "$DOTFILES"
fi

# Directories
echo "Creating home directories..."
mkdir -p "$HOME"/{.config,Downloads,Scripts}

# Paru
if ! command -v paru &>/dev/null; then
    echo "Installing paru..."
    git clone https://aur.archlinux.org/paru.git /tmp/paru
    (cd /tmp/paru && makepkg -si --noconfirm)
fi

# Packages
echo "Installing pacman packages..."
sudo pacman -S --noconfirm --needed "${PACMAN_PACKAGES[@]}"

echo "Installing AUR packages..."
paru -S --noconfirm --needed "${AUR_PACKAGES[@]}"

# Default shell
if [[ "$SHELL" != "$(which zsh)" ]]; then
    echo "Changing default shell to zsh..."
    sudo chsh -s "$(which zsh)" "$USER"
fi

# Symlinks
echo "Creating symlinks..."
ln -sf "$DOTFILES/.zshrc"          "$HOME/.zshrc"
ln -sf "$DOTFILES/.zprofile"       "$HOME/.zprofile"
ln -sf "$DOTFILES/.config/hypr"    "$HOME/.config/hypr"
ln -sf "$DOTFILES/.config/waybar"  "$HOME/.config/waybar"

# Neovim config
if [[ ! -d "$HOME/.config/nvim" ]]; then
    echo "Cloning Neovim config..."
    git clone https://github.com/itzDJ/nvim "$HOME/.config/nvim"
fi

echo "Done. Log out and back in to apply shell changes."
