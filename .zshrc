# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-syntax-highlighting"

plug "MAHcodes/distro-prompt"
plug "wintermi/zsh-lsd"

# Load and initialise completion system
autoload -Uz compinit
compinit

# Aliases
alias vim="nvim"
