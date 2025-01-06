# Update Debian
sudo apt update && sudo apt full-upgrade -y

# Install zsh and make it default
if [[ "$SHELL" != "/usr/bin/zsh" ]]; then
    sudo apt install zsh
    chsh -s /usr/bin/zsh
fi

# Install git and clone dotfiles
printf "\nInstalling git...\n"
sudo apt install git
printf "\nCloning dotfiles...\n"
git clone https://github.com/itzDJ/.dotfiles $HOME/.dotfiles

# Install packages
# TODO: MAKE THIS ITS OWN FILE LIKE BREWFILE AND ADD MORE PACKAGES
sudo apt install neovim alacritty tmux neofetch pipx

# Install qtile wm
sudo apt install xserver-xorg xinit
sudo apt install libpangocairo-1.0-0
sudo apt install python3-pip python3-xcffib python3-cairocffi
pipx install qtile

echo "exec qtile start" > ~/.xinitrc
# TODO: must still call `startx` when logged in. can be fixed by calling `startx` from .zprofile

# --------------------------
# Install mullvad vpn
# Download the Mullvad signing key
sudo curl -fsSLo /usr/share/keyrings/mullvad-keyring.asc https://repository.mullvad.net/deb/mullvad-keyring.asc

# Add the Mullvad repository server to apt
echo "deb [signed-by=/usr/share/keyrings/mullvad-keyring.asc arch=$( dpkg --print-architecture )] https://repository.mullvad.net/deb/stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/mullvad.list

# Install the package
sudo apt update
sudo apt install mullvad-vpn
# --------------------------

# --------------------------
# Install brave
curl -fsS https://dl.brave.com/install.sh | sh
# --------------------------

# Install zap-zsh
printf "\nInstalling zap-zsh...\n"
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1

# Install zsh config
printf "\nInstalling zsh config...\n"
mv ~/.dotfiles/mac/.zshrc ~/.zshrc

# Install alacritty config
printf "\nInstalling alacritty config...\n"
mkdir -p ~/.config/alacritty
mv ~/.dotfiles/mac/alacritty.toml ~/.config/alacritty/alacritty.toml

# Install WM config
printf "\nInstalling WM config...\n"
mkdir -p ~/.config/qtile
mv ~/.dotfiles/debian/qtile_config.py ~/.config/qtile/config.py

printf "\nInstalling neovim config...\n"
rm -rf ~/.config/nvim # HACK
git clone https://github.com/itzDJ/djvim ~/.config/nvim
