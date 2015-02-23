# .zshrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Source global definitions
if [ -f /etc/zshrc ]; then
    . /etc/zshrc
fi

# ------------------------------
bindkey -e

autoload -Uz colors; colors
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '+'
zstyle ':vcs_info:git:*' unstagedstr '*'
zstyle ':vcs_info:git:*' formats "%F{yellow}<%b%u%c>%f "
zstyle ':vcs_info:git:*' actionformats '[%b|%a]'
precmd () { vcs_info }

[[ -n $VIMRUNTIME ]] && vim='%F{red}*vim*%f '

PROMPT='${vim}%F{green}%n%f@%F{cyan}%m%f:%F{blue}%~%f ${vcs_info_msg_0_}%# '

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_all_dups
setopt hist_save_nodups

autoload -Uz compinit; compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
setopt list_packed

setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt correct

peco-history() {
  BUFFER=$(fc -l -n 1 | tac | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
}
zle -N peco-history
bindkey '^r' peco-history

peco-kill() {
  PID=`ps aux | peco | awk '{ print $2 }'`
  echo "kill pid: $PID"
  kill $PID
}
zle -N peco-kill
bindkey '^k' peco-kill
