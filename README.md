# .dotfiles

## Install

Clone repo, unpack submodules, brew install packages, and stow files

```bash
git clone --recurse-submodules https://github.com/itzDJ/.dotfiles $HOME/.dotfiles
cd $HOME/.dotfiles
brew bundle install
stow env
```
