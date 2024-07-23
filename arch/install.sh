printf "Linux detected; Arch assumed\n"

# Update Arch
sudo pacman -Syu --noconfirm

# Install zsh and make it default
if [[ "$SHELL" != "/usr/bin/zsh" ]]; then
    sudo pacman -S zsh
    chsh -s /usr/bin/zsh
fi

# Install git and clone dotfiles
printf "\nInstalling git...\n"
sudo pacman -S --needed --noconfirm git
printf "\nCloning dotfiles...\n"
git clone https://github.com/itzDJ/.dotfiles $HOME/.dotfiles

# Install yay and other packages
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay
yay -S --needed --noconfirm - < ~/.dotfiles/arch/arch_packages.txt

# Install zap-zsh
printf "\nInstalling zap-zsh...\n"
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1

# Install zsh config
printf "\nInstalling zsh config...\n"
mv ~/.dotfiles/mac/.zshrc ~/.zshrc
mv ~/.dotfiles/arch/.zprofile ~/.zprofile

# Install alacritty config
printf "\nInstalling alacritty config...\n"
mkdir -p ~/.config/alacritty
mv ~/.dotfiles/mac/alacritty.toml ~/.config/alacritty/alacritty.toml

# Install neovim config through its git repo
printf "\nInstalling neovim config...\n"
rm -rf ~/.config/nvim # HACK
git clone https://github.com/itzDJ/djvim ~/.config/nvim

# Install WM config
printf "\nInstalling WM config...\n"
rm -rf ~/.config/hypr # HACK
mv ~/.dotfiles/arch/hypr ~/.config/hypr
rm -rf ~/.config/waybar # HACK
mv ~/.dotfiles/arch/waybar ~/.config/waybar
rm -rf ~/.config/wofi # HACK
mv ~/.dotfiles/arch/wofi ~/.config/wofi

# Misc setup
printf "\nSetting up misc...\n"
# Setup Nemo
xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search
gsettings set org.cinnamon.desktop.default-applications.terminal exec alacritty

printf "\nReboot to finish setup\n"
