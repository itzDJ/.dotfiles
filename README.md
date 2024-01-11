# DJ's dotfiles

## Install

```bash
bash <(curl https://raw.githubusercontent.com/itzDJ/.dotfiles/main/install.sh)
```

## Setup steps (should only be needed once)

### Create .dotfiles git repo

Consider switching from standard git repo to [bare git repo](https://www.atlassian.com/git/tutorials/dotfiles)

### Submodule notes

```bash
# Create .gitmodules file
touch .gitmodules

# Once in .dotfiles git repo, add soft link to necessary repositories (ex: nvim)
git submodule add --force https://github.com/itzDJ/djs-neovim

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
