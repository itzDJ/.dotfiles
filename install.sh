#!/bin/bash
# Install script for dotfiles

# Check OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "MacOS detected"

    # Install homebrew
    which -s brew # Return 0 if brew is installed
    if [[ $? != 0 ]]; then # if the output of the previous command is not 0,
        echo "Homebrew not found; installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo 'eval $(/opt/homebrew/bin/brew shellenv)' >> $HOME/.zprofile
    else
        echo "Homebrew found; updating..."
        brew update && brew upgrade --greedy
    fi

    # Install Brewfile
    echo "Installing homebrew packages..."
    brew bundle install --file ~/.dotfiles/Brewfile

    # Install zap-zsh
    echo "Installing zap-zsh..."
    zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1

    # Install zsh config
    echo "Installing zsh config..."
    mv ~/.dotfiles/.zshrc ~/.zshrc

    # Enable press and hold for repeating keys in default macOS terminal
    defaults write com.apple.Terminal ApplePressAndHoldEnabled -bool false

    # Install alacritty config
    echo "Installing alacritty config..."
    mv ~/.dotfiles/alacritty.toml ~/.config/alacritty/alacritty.toml

    # Install neovim config through git submodules
    echo "Installing neovim config..."
    mv ~/.dotfiles/nvim ~/.config/nvim
    echo "Run 'nvim' to finish setup"
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
    echo "Linux detected; Arch assumed" # TODO: Check for linux type and install accordingly (arch vs debian)

    # Install zsh and make it default
    sudo pacman -S zsh
    chsh -s /usr/bin/zsh

    # Install pacman packages
    sudo pacman -S --needed - < pacman_packages.txt

    # Install aur packages
    echo "Installing minecraft-launcher..."
    git clone https://aur.archlinux.org/minecraft-launcher.git && cd minecraft-launcher && makepkg -si && cd .. && rm -rf minecraft-launcher
    # TODO CONTINUE ADDING AUR PACKAGES

    # Install zap-zsh
    echo "Installing zap-zsh..."
    zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1

    # Install zsh config
    echo "Installing zsh config..."
    mv ~/.dotfiles/.zshrc ~/.zshrc

    # Install alacritty config
    echo "Installing alacritty config..."
    mv ~/.dotfiles/alacritty.toml ~/.config/alacritty/alacritty.toml

    # Install neovim config through git submodules
    echo "Installing neovim config..."
    mv ~/.dotfiles/nvim ~/.config/nvim
    echo "Run 'nvim' to finish setup"

    # Install WM config (hyprland)
    # TODO
else
    echo "OS not supported"
    exit 1
fi
