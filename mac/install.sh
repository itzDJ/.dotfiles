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
brew bundle install --file ~/.dotfiles/mac/Brewfile

# Install zap-zsh
printf "\nInstalling zap-zsh...\n"
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1

# Install zsh config
printf "\nInstalling zsh config...\n"
mv ~/.dotfiles/mac/.zshrc ~/.zshrc
source ~/.zshrc

# Enable press and hold for repeating keys in default macOS terminal
defaults write com.apple.Terminal ApplePressAndHoldEnabled -bool false

# Install alacritty config
printf "\nInstalling alacritty config...\n"
mkdir -p ~/.config/alacritty
mv ~/.dotfiles/mac/alacritty.toml ~/.config/alacritty/alacritty.toml

# Install aerospace config
printf "\nInstalling aerospace config...\n"
mkdir -p ~/.config/aerospace
mv ~/.dotfiles/mac/aerospace.toml ~/.config/aerospace/aerospace.toml

# Install neovim and its config through its git repo
printf "\nInstalling neovim and its config...\n"
# sudo mv ~/.dotfiles/mac/nvim-update.sh /opt
# nvim-update
rm -rf ~/.config/nvim # HACK Find way to combine this with the next line
git clone https://github.com/itzDJ/djvim ~/.config/nvim

printf "\nSetup complete\n"
