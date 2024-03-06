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

### macOS: homebrew packages

```bash
# Create a Brewfile (all installed packages)
brew bundle dump
```

### Arch packages

```bash
# Creates a file with all packages explicitly installed and not required as dependencies
yay -Qqet > arch_packages.txt
```
