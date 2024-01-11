# DJ's dotfiles

## Install

```bash
bash <(curl https://raw.githubusercontent.com/itzDJ/.dotfiles/main/install.sh)
```

## NOTE

Neovim config is added through its own repo

## Setup steps (should only be needed once)

### Create .dotfiles git repo

Consider switching from standard git repo to [bare git repo](https://www.atlassian.com/git/tutorials/dotfiles)

### Homebrew packages

```bash
# Create a Brewfile (all installed packages)
brew bundle dump
```

### Arch packages

```bash
# Get explicitly installed packages from pacman excluding dependencies
pacman -Qqen > pacman_packages.txt

# Get packages installed outside of main repos (i.e. Installed from AUR)
pacman -Qm > aur_packages.txt
```
