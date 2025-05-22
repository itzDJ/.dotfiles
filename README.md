# .dotfiles

## Install

Clone repo and unpack submodules, add brew to path, brew install packages, and stow files

```bash
git clone --recurse-submodules https://github.com/itzDJ/.dotfiles $HOME/.dotfiles
cd $HOME/.dotfiles
eval "$(/opt/homebrew/bin/brew shellenv)"
brew bundle install
stow env
```
