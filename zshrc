# Initialization {{{1

# Disable START/STOP output control to release the C-s/C-q keybindings.
tty -s && stty -ixon

# Powerlevel10k Instant Prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zplug {{{1

export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "romkatv/powerlevel10k", as:theme, depth:1
zplug "blooper05/anyframe", at:add-skim_support
zplug "blooper05/git-cococo", as:command, use:exe/git-cococo
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug check || zplug install

zplug load

# Environment Variable {{{1

# PATH
typeset -U path PATH
export PATH=$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:$PATH

# XDG Base Directory Specification
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# Language
export LANGUAGE="en_US.UTF-8"
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="${LANGUAGE}"

# Tools
export SHELL=zsh
export EDITOR=nvim
export PAGER=less

# Alias {{{1

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias ls='exa --classify --group-directories-first'
alias ll='exa --classify --group-directories-first --long'
alias lt='exa --classify --group-directories-first --long --sort newest'
alias la='exa --all --classify --group-directories-first --long'
alias tree='exa --classify --group-directories-first --tree'
alias cat='bat'
alias du='dust'
# alias find='fd'
alias ps='procs'
# alias grep='rg'
# alias sed='sd'
alias top='btm'
alias watch='watchexec'
alias dig='dog'
alias ping='gping'
alias curl='xh'

# Key Binding {{{1

# Use Emacs mode.
bindkey -e

# History {{{1

# Set the history file path and its size.
export HISTFILE=$XDG_DATA_HOME/zsh/history
export HISTSIZE=10000 # in memory
export SAVEHIST=10000 # on file

# Don't record an event that was recorded just before.
setopt hist_ignore_dups

# Don't record an event that was already recorded (not just before).
setopt hist_ignore_all_dups

# Omit duplicate older commands when writing out the history file.
setopt hist_save_no_dups

# Remove the oldest history event that has a duplicate before a unique event.
setopt hist_expire_dups_first

# Don't display duplicates, even if the duplicates are not contiguous.
setopt hist_find_no_dups

# TODO: Add comments
setopt hist_ignore_space
setopt share_history
setopt hist_reduce_blanks
setopt inc_append_history
setopt hist_no_functions
setopt extended_history
setopt append_history
setopt hist_verify
setopt bang_hist

zshaddhistory() {
  local line=${1%%$'\n'}
  local cmd=${line%% *}

  [[ ${#line} -ge 5
    && ${cmd} != (brew|mas|zplug)
    && ${cmd} != (cd)
    && ${cmd} != (cp|mv|rm|mkdir)
    && ${cmd} != (echo|cat)
    && ${cmd} != (grep|rg)
    && ${cmd} != (kill)
    && ${cmd} != (l[slta]|tree)
    && ${cmd} != (man)
    && ${cmd} != (open)
    && ${cmd} != (vi|vim|nvim)
  ]]
}

# Completion {{{1

autoload -Uz compinit && compinit -u -d $XDG_DATA_HOME/zsh/compdump
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' format '%B%d%b%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
setopt list_packed
setopt correct
setopt correct_all
CORRECT_IGNORE='_*'
CORRECT_IGNORE_FILE='.*'

# Moving {{{1

setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

# Tools {{{1

# Homebrew Bundle {{{2
export HOMEBREW_BUNDLE_FILE=$XDG_CONFIG_HOME/homebrew/Brewfile

# Neovim {{{2
alias vi='nvim'
alias vim='nvim'

# Less {{{2
export LESS=-inqMRS
export LESSCHARSET=utf-8
export LESSHISTFILE=$XDG_DATA_HOME/less/history

# asdf {{{2
export ASDF_CONFIG_FILE=$XDG_CONFIG_HOME/asdf/asdfrc
export ASDF_DATA_DIR=$XDG_DATA_HOME/asdf
source $(brew --prefix asdf)/asdf.sh

# Node.js {{{2
export NPM_CONFIG_CACHE=$XDG_CACHE_HOME/npm

# Go {{{2
export GOPATH=$XDG_DATA_HOME/go
export PATH=$GOPATH/bin:$PATH

# skim {{{2
export SKIM_DEFAULT_OPTIONS='--multi --reverse --ansi --select-1 --exit-0'

# anyframe {{{2
bindkey '^k' anyframe-widget-kill
bindkey '^r' anyframe-widget-put-history
bindkey '^s' anyframe-widget-cd-ghq-repository
bindkey '^g^a' anyframe-widget-git-add
bindkey '^g^b' anyframe-widget-checkout-git-branch

# ghq {{{2
export GHQ_ROOT=$XDG_DATA_HOME/ghq

# gh {{{2
eval "$(gh completion -s zsh)"

# gpg {{{2
export GPG_TTY=$(tty)
export GNUPGHOME=$XDG_DATA_HOME/gnupg

# AWS CLI {{{2
export AWS_CONFIG_FILE=$XDG_CONFIG_HOME/aws/config
export AWS_SHARED_CREDENTIALS_FILE=$XDG_CONFIG_HOME/aws/credentials

# Terraform {{{2
export TF_CLI_ARGS_plan="--parallelism=30"
export TF_CLI_ARGS_apply="--parallelism=30"

# Powerlevel10k {{{2
source $XDG_CONFIG_HOME/zsh/powerlevel10k.zsh

# starship {{{2
# eval "$(starship init zsh)"
# export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/config.toml

# Folding {{{1

# vim:set foldmethod=marker:
