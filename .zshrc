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
bindkey -v

autoload -Uz colors; colors
PROMPT="%{${fg[cyan]}%}[%n@%m]%{${reset_color}%} %~
%# "

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
