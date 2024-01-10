# DJ's dotfiles

## Install

Clone into `$HOME` directory and run install script

```bash
git clone --recurse-submodules https://github.com/itzDJ/.dotfiles $HOME/.dotfiles && /bin/bash ~/.dotfiles/install.sh
```

## Setup steps (should only be needed once)

### Create .dotfiles git repo

### Submodule notes

```bash
# Once in .dotfiles git repo, add soft link to necessary repositories (ex: nvim)
git submodule add https://github.com/itzDJ/djs-neovim

# Move or rename a file, directory, or symlink (ex: rename djs-neovim to nvim)
git mv djs-neovim nvim
```

### Homebrew packages

```bash
# Create a Brewfile (all installed packages)
brew bundle dump
```

### Arch packages

```bash
# Get explicitly installed packages from pacman excluding dependencies
pacman -Qqetn > pacman_packages.txt

# Get packages installed outside of main repos (i.e. Installed from AUR)
pacman -Qm > aur_packages.txt
```
