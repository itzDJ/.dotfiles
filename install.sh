#!/bin/bash
##### Install / update script for dotfiles #####

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
    git clone https://github.com/itzDJ/.dotfiles $HOME/.dotfiles

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
    git clone https://github.com/itzDJ/djs-neovim ~/.config/nvim

    printf "\nSetup complete\n"
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
    printf "Linux detected; Arch assumed\n"

    # Update Arch
    sudo pacman -Syu

    # Install zsh and make it default
    if [[ "$SHELL" != "/usr/bin/zsh" ]]; then
        sudo pacman -S zsh
        chsh -s /usr/bin/zsh
    fi

    # Install git and clone dotfiles
    printf "\nInstalling git...\n"
    sudo pacman -S --needed git
    printf "\nCloning dotfiles...\n"
    git clone https://github.com/itzDJ/.dotfiles $HOME/.dotfiles

    # Install pacman packages
    sudo pacman -S --needed - < ~/.dotfiles/pacman_packages.txt

    # Install aur packages
    printf "\nInstalling minecraft-launcher...\n"
    git clone https://aur.archlinux.org/minecraft-launcher.git && cd minecraft-launcher && makepkg -si && cd .. && rm -rf minecraft-launcher

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
    rm -rf ~/.config/nvim # HACK
    git clone https://github.com/itzDJ/djs-neovim ~/.config/nvim

    # Install WM (qtile) config
    printf "\nInstalling WM (qtile) config...\n"
    mv ~/.dotfiles/qtile_config.py ~/.config/qtile/config.py

    printf "\nReboot to finish setup\n"
else
    printf "OS not supported. Exiting...\n"
    exit 1
fi

# Remove dotfiles directory
rm -rf ~/.dotfiles
