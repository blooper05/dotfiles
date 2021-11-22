# Initialization {{{1

# Disable START/STOP output control to release the C-s/C-q keybindings.
tty -s && stty -ixon

# Set GPG TTY.
export GPG_TTY=$(tty)

# Powerlevel10k Instant Prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Environment Variable {{{1

# PATH
typeset -U path PATH
export PATH=$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:$PATH

# XDG Base Directory Specification
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

# Language
export LANGUAGE="en_US.UTF-8"
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="${LANGUAGE}"

# Tools
export SHELL=/usr/local/bin/zsh
export EDITOR=nvim
export PAGER=less

# Zinit {{{1

declare -A ZINIT

ZINIT[HOME_DIR]=$XDG_DATA_HOME/zinit
ZINIT[ZCOMPDUMP_PATH]=$XDG_DATA_HOME/zsh/compdump

source /usr/local/opt/zinit/zinit.zsh

zinit ice depth:1
zinit light romkatv/powerlevel10k

zinit ice depth:1 wait lucid \
  atclone:'dircolors -b LS_COLORS > clrs.zsh' \
  atpull:'%atclone' pick:'clrs.zsh' nocompile:'!' \
  atload:'zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"'
zinit light trapd00r/LS_COLORS

zinit ice depth:1 wait lucid atinit:'zicompinit; zicdreplay;'
zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice depth:1 wait lucid atload:'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

zinit ice depth:1 wait lucid atpull:'zinit creinstall -q .' blockf
zinit light zsh-users/zsh-completions

zinit ice depth:1 wait lucid
zinit light hlissner/zsh-autopair

# zinit ice depth:1 wait lucid
# zinit light jeffreytse/zsh-vi-mode

zinit ice depth:1 ver:'add-skim_support'
zinit light blooper05/anyframe

zinit ice depth:1 wait lucid as:'program' pick:'exe/git-cococo'
zinit light blooper05/git-cococo

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
  ]] && whence ${${(z)1}[1]} >| /dev/null || return 1
}

# Completion {{{1

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' format '%B%d%b%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' menu select=2
setopt list_packed
setopt correct
setopt correct_all
CORRECT_IGNORE='_*'
CORRECT_IGNORE_FILE='.*'
# alias cp='nocorrect cp'
# alias mv='nocorrect mv'
# alias mkdir='nocorrect mkdir'

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
export GNUPGHOME=$XDG_DATA_HOME/gnupg

# AWS CLI {{{2
export AWS_CONFIG_FILE=$XDG_CONFIG_HOME/aws/config
export AWS_SHARED_CREDENTIALS_FILE=$XDG_CONFIG_HOME/aws/credentials

# Terraform {{{2
export TF_CLI_ARGS_plan="--parallelism=30"
export TF_CLI_ARGS_apply="--parallelism=30"

# Taskwarrior {{{2
export TASKDATA=$XDG_DATA_HOME/task
export TASKRC=$XDG_CONFIG_HOME/task/taskrc

# Timewarrior {{{2
export TIMEWARRIORDB=$XDG_DATA_HOME/timew

# Powerlevel10k {{{2
source $XDG_CONFIG_HOME/zsh/powerlevel10k.zsh

# starship {{{2
# eval "$(starship init zsh)"
# export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/config.toml

# Folding {{{1

# vim:set foldmethod=marker:
