# completion
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list \
  'm:{a-zA-Z}={A-Za-z}' \
  'r:|[._-]=* r:|=*' \
  'l:|=* r:|=*'
zstyle ':completion:*' menu select

# history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

# bindkey
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward
bindkey -v

# prompt with git repo check
autoload -Uz vcs_info
precmd() { vcs_info }
setopt prompt_subst
zstyle ':vcs_info:git:*' formats ' [%b]'
PROMPT='%~${vcs_info_msg_0_} %# '

# exports
export EDITOR=nvim
export VISUAL=nvim

# aliases
alias vim=nvim
alias sudo='sudo '
alias ls='eza --icons'

# plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
