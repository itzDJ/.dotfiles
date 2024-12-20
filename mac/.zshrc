# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zap-zsh/zap-prompt"
plug "zsh-users/zsh-syntax-highlighting"

# Load and initialise completion system
autoload -Uz compinit
compinit

# Path
# export PATH="$PATH:/opt/nvim-macos-arm64/bin"

# Env variables
export VISUAL=nvim
export EDITOR=nvim

# Aliases
alias sudo='sudo '
alias vim=nvim
# alias nvim-update='sudo bash /opt/nvim-update.sh'

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/dj/.cache/lm-studio/bin"
