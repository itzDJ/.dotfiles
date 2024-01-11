#!/bin/bash
##### Install script for dotfiles #####
# TODO Script is currently for installing on new machine; make it work for updating as well

# Check OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    printf "MacOS detected\n"

    # Install homebrew
    if ! command -v brew &>/dev/null; then
        printf "\nHomebrew not found; installing...\n"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        printf "\nHomebrew found; updating...\n"
        brew update && brew upgrade --greedy
    fi

    # Install git and clone dotfiles
    printf "\nInstalling git...\n"
    brew install git
    printf "\nCloning dotfiles...\n"
    git clone --recurse-submodules https://github.com/itzDJ/.dotfiles $HOME/.dotfiles

    # Install Brewfile
    printf "\nInstalling homebrew packages...\n"
    brew bundle install --file ~/.dotfiles/Brewfile

    # Install zap-zsh
    printf "\nInstalling zap-zsh...\n"
    zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1

    # Install zsh config
    printf "\nInstalling zsh config...\n"
    mv ~/.dotfiles/.zshrc ~/.zshrc

    # Enable press and hold for repeating keys in default macOS terminal
    defaults write com.apple.Terminal ApplePressAndHoldEnabled -bool false

    # Install alacritty config
    printf "\nInstalling alacritty config...\n"
    mkdir -p ~/.config/alacritty
    mv ~/.dotfiles/alacritty.toml ~/.config/alacritty/alacritty.toml

    # Install neovim config through git submodules
    printf "\nInstalling neovim config...\n"
    rm -rf ~/.config/nvim # HACK Find way to combine this with the next line
    mv ~/.dotfiles/nvim ~/.config/nvim
    printf "\nRun 'nvim' to finish setup\n"
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
    printf "Linux detected; Arch assumed\n" # TODO: Check for linux type and install accordingly (arch vs debian)

    # Install zsh and make it default
    sudo pacman -S zsh
    chsh -s /usr/bin/zsh

    # Install git and clone dotfiles
    printf "\nInstalling git...\n"
    sudo pacman -S git
    printf "\nCloning dotfiles...\n"
    git clone --recurse-submodules https://github.com/itzDJ/.dotfiles $HOME/.dotfiles

    # Install pacman packages
    sudo pacman -S --needed - < pacman_packages.txt

    # Install aur packages
    printf "\nInstalling minecraft-launcher...\n"
    git clone https://aur.archlinux.org/minecraft-launcher.git && cd minecraft-launcher && makepkg -si && cd .. && rm -rf minecraft-launcher
    # TODO CONTINUE ADDING AUR PACKAGES

    # Install zap-zsh
    printf "\nInstalling zap-zsh...\n"
    zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1

    # Install zsh config
    printf "\nInstalling zsh config...\n"
    mv ~/.dotfiles/.zshrc ~/.zshrc

    # Install alacritty config
    printf "\nInstalling alacritty config...\n"
    mkdir -p ~/.config/alacritty
    mv ~/.dotfiles/alacritty.toml ~/.config/alacritty/alacritty.toml

    # Install neovim config through git submodules
    printf "\nInstalling neovim config...\n"
    rm -rf ~/.config/nvim # HACK Find way to combine this with the next line
    mv ~/.dotfiles/nvim ~/.config/nvim
    printf "\nRun 'nvim' to finish setup\n"

    # Install DE/WM config (hyprland)
    # TODO These need to overwrite existing files
    printf "\nInstalling DE/WM config...\n"
    mv ~/.dotfiles/hypr ~/.config/hypr
    mv ~/.dotfiles/waybar ~/.config/waybar
    mv ~/.dotfiles/wofi ~/.config/wofi
else
    printf "OS not supported. Exiting...\n"
    exit 1
fi

# Remove dotfiles directory
rm -rf ~/.dotfiles
