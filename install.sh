#!/usr/bin/env bash

# Exit on error
set -e

# Exit if system isn't running archlinux
if [[ ! -f /etc/arch-release ]]; then
    echo "Error: Failed to detect /etc/arch-release"
    exit 1
fi

# Cache sudo credentials
sudo -v

# Update system
sudo pacman -Syu --noconfirm

# Install AUR helper
sudo pacman -S --noconfirm --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay

# Cleanup old bash files
rm .bash*

# Zsh setup
yay -S --noconfirm --needed zsh
sudo chsh -s $(which zsh) $USER
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install packages (ignore lines that begin with a hashtag)
git clone https://github.com/itzDJ/.dotfiles $HOME/.dotfiles
yay -S --noconfirm --needed $(grep -v "^#" $HOME/.dotfiles/packages.txt)

# Setup pyenv
pyenv install 3
pyenv global 3

# Dotfiles symlinks
ln -sf "$HOME/.dotfiles/.zshrc" "$HOME/.zshrc"
ln -sf "$HOME/.dotfiles/.zprofile" "$HOME/.zprofile"
ln -sf "$HOME/.dotfiles/.config/hypr" "$HOME/.config/hypr"
ln -sf "$HOME/.dotfiles/.config/waybar" "$HOME/.config/waybar"
ln -sf "$HOME/.dotfiles/.config/wofi" "$HOME/.config/wofi"

# Install neovim config (git submodules are annoying, so this is a workaround)
git clone https://github.com/itzDJ/nvim ~/.config/nvim

# Reboot to finish install
echo -n "Rebooting in "
for i in {3..1}; do
    echo -n "$i..."
    sleep 1
done
sudo systemctl reboot
