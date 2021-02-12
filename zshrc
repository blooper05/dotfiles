# zplug {{{1

export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

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

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
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
# alias wc='tokei'
alias top='btm'

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
    && ${cmd} != (cd)
    && ${cmd} != (kill)
    && ${cmd} != (l[slta])
    && ${cmd} != (man)
    && ${cmd} != (rm)
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

# Ruby {{{2
export GEMRC=$XDG_CONFIG_HOME/gem/gemrc
export BUNDLE_CONFIG=$XDG_CONFIG_HOME/bundler/config
export GEM_SPEC_CACHE=$XDG_CACHE_HOME/gem/specs

# rbenv {{{2
export RBENV_ROOT=/usr/local/var/rbenv
if type rbenv > /dev/null; then eval "$(rbenv init -)"; fi
# if [ ! -f $RBENV_ROOT/default-gems ]; then
#   echo bundler             >> $RBENV_ROOT/default-gems
#   echo neovim              >> $RBENV_ROOT/default-gems
#   echo rubocop             >> $RBENV_ROOT/default-gems
#   echo rubocop-inflector   >> $RBENV_ROOT/default-gems
#   echo rubocop-performance >> $RBENV_ROOT/default-gems
#   echo rubocop-rspec       >> $RBENV_ROOT/default-gems
#   echo solargraph          >> $RBENV_ROOT/default-gems
# fi

# Node.js {{{2
export NPM_CONFIG_CACHE=$XDG_CACHE_HOME/npm

# nodenv {{{2
export NODENV_ROOT=/usr/local/var/nodenv
if type nodenv > /dev/null; then eval "$(nodenv init -)"; fi

# Go {{{2
export GOPATH=$XDG_DATA_HOME/go
export PATH=$GOPATH/bin:$PATH

# tmux {{{2
function is_tmux_runnning() { [ ! -z "$TMUX" ]; }
function is_interactive() { [ ! -z "$PS1" ]; }
function is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }
function tmux_automatically_attach_session()
{
  if ! is_tmux_runnning && is_interactive && ! is_ssh_running; then
    if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '.*]$'; then
      tmux list-sessions
      echo -n 'tmux: attach? (y/N/num) '
      read
      if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" == '' ]]; then
        tmux attach-session
      elif [[ "$REPLY" =~ ^[0-9]+$ ]]; then
        tmux attach -t "$REPLY"
      fi
    else
      tmux new-session
    fi
  fi
}
tmux_automatically_attach_session

# fzf {{{2
export FZF_DEFAULT_OPTS='--extended --cycle --reverse --ansi --select-1 --exit-0 --no-mouse --multi'

# anyframe {{{2
bindkey '^k' anyframe-widget-kill
bindkey '^r' anyframe-widget-put-history
bindkey '^s' anyframe-widget-cd-ghq-repository
bindkey '^g^a' anyframe-widget-git-add
bindkey '^g^b' anyframe-widget-checkout-git-branch

if [[ -t 0 ]]; then
  stty stop undef
  stty start undef
fi

# ghq {{{2
export GHQ_ROOT=$XDG_DATA_HOME/ghq

# gh {{{2
eval "$(gh completion -s zsh)"

# gpg {{{2
export GPG_TTY=$(tty)

# AWS CLI {{{2
export AWS_CONFIG_FILE=$XDG_CONFIG_HOME/aws/config
export AWS_SHARED_CREDENTIALS_FILE=$XDG_CONFIG_HOME/aws/credentials

# Terraform {{{2
export TF_CLI_ARGS_plan="--parallelism=30"
export TF_CLI_ARGS_apply="--parallelism=30"

# Folding {{{1

# vim:set foldmethod=marker:
