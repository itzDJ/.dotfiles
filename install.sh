#!/bin/bash
##### Install script for dotfiles #####
# TODO Script is currently for installing on new machine; make it work for updating as well

# Check OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    printf "\nMacOS detected\n"

    # Install homebrew
    if ! command -v brew &>/dev/null; then
        printf "\nHomebrew not found; installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        printf "\nHomebrew found; updating..."
        brew update && brew upgrade --greedy
    fi

    # Install git and clone dotfiles
    printf "\nInstalling git..."
    brew install git
    printf "\nCloning dotfiles..."
    git clone --recurse-submodules https://github.com/itzDJ/.dotfiles $HOME/.dotfiles

    # Install Brewfile
    printf "\nInstalling homebrew packages..."
    brew bundle install --file ~/.dotfiles/Brewfile

    # Install zap-zsh
    printf "\nInstalling zap-zsh..."
    zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1

    # Install zsh config
    printf "\nInstalling zsh config..."
    mv ~/.dotfiles/.zshrc ~/.zshrc

    # Enable press and hold for repeating keys in default macOS terminal
    defaults write com.apple.Terminal ApplePressAndHoldEnabled -bool false

    # Install alacritty config
    printf "\nInstalling alacritty config..."
    mkdir -p ~/.config/alacritty
    mv ~/.dotfiles/alacritty.toml ~/.config/alacritty/alacritty.toml

    # Install neovim config through git submodules
    printf "\nInstalling neovim config..."
    mv ~/.dotfiles/nvim ~/.config/nvim
    printf "\nRun 'nvim' to finish setup"
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
    printf "\nLinux detected; Arch assumed\n" # TODO: Check for linux type and install accordingly (arch vs debian)

    # Install zsh and make it default
    sudo pacman -S zsh
    chsh -s /usr/bin/zsh

    # Install git and clone dotfiles
    printf "\nInstalling git..."
    sudo pacman -S git
    printf "\nCloning dotfiles..."
    git clone --recurse-submodules https://github.com/itzDJ/.dotfiles $HOME/.dotfiles

    # Install pacman packages
    sudo pacman -S --needed - < pacman_packages.txt

    # Install aur packages
    printf "\nInstalling minecraft-launcher..."
    git clone https://aur.archlinux.org/minecraft-launcher.git && cd minecraft-launcher && makepkg -si && cd .. && rm -rf minecraft-launcher
    # TODO CONTINUE ADDING AUR PACKAGES

    # Install zap-zsh
    printf "\nInstalling zap-zsh..."
    zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1

    # Install zsh config
    printf "\nInstalling zsh config..."
    mv ~/.dotfiles/.zshrc ~/.zshrc

    # Install alacritty config
    printf "\nInstalling alacritty config..."
    mkdir -p ~/.config/alacritty
    mv ~/.dotfiles/alacritty.toml ~/.config/alacritty/alacritty.toml

    # Install neovim config through git submodules
    printf "\nInstalling neovim config..."
    mv ~/.dotfiles/nvim ~/.config/nvim
    printf "\nRun 'nvim' to finish setup"

    # Install DE/WM config (hyprland)
    # TODO These need to overwrite existing files
    printf "\nInstalling DE/WM config..."
    mv ~/.dotfiles/hypr ~/.config/hypr
    mv ~/.dotfiles/waybar ~/.config/waybar
    mv ~/.dotfiles/wofi ~/.config/wofi
else
    printf "\nOS not supported. Exiting..."
    exit 1
fi

# Remove dotfiles directory
rm -rf ~/.dotfiles
