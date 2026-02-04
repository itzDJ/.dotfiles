# Completion
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list \
  'm:{a-zA-Z}={A-Za-z}' \
  'r:|[._-]=* r:|=*' \
  'l:|=* r:|=*'
zstyle ':completion:*' menu select

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

# Prompt with git repo check
autoload -Uz vcs_info
precmd() { vcs_info }
setopt prompt_subst
zstyle ':vcs_info:git:*' formats ' [%b]'
PROMPT='%~${vcs_info_msg_0_} %# '

# Exports
export EDITOR=nvim
export VISUAL=nvim

# Aliases
alias vim=nvim
alias sudo='sudo '
alias ls='ls --color=auto'

# Plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
