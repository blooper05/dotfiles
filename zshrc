# zplug {{{1

export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "Code-Hex/battery", as:command, from:gh-r
zplug "bhilburn/powerlevel9k", as:theme
zplug "glidenote/hub-zsh-completion"
zplug "mollifier/anyframe"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug check || zplug install

zplug load

# Environment Variable {{{1

# PATH
typeset -U path PATH
export PATH=/usr/local/bin:$PATH

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
alias ls='ls -FG'
alias ll='ls -FGhl'
alias lt='ls -FGhlt'
alias la='ls -AFGhl'

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
# TODO: Add comments
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_expire_dups_first
setopt hist_find_no_dups
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

# Homebrew-file {{{2
if [ -f $(brew --prefix)/etc/brew-wrap ]; then
  source $(brew --prefix)/etc/brew-wrap
fi

# Neovim {{{2
alias vi='nvim'
alias vim='nvim'

# Less {{{2
export LESS=-inqMRS
export LESSCHARSET=utf-8
export LESSHISTFILE=$XDG_DATA_HOME/less/history

# Ruby {{{2
export GEMRC=$XDG_CONFIG_HOME/gem/gemrc
export PRYRC=$XDG_CONFIG_HOME/pry/pryrc
export BUNDLE_CONFIG=$XDG_CONFIG_HOME/bundler/config
export GEM_SPEC_CACHE=$XDG_CACHE_HOME/gem/specs
export RUBYGEMS_GEMDEPS=-

# rbenv {{{2
export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
if [ ! -f $RBENV_ROOT/default-gems ]; then
  echo bundler    >> $RBENV_ROOT/default-gems
  echo neovim     >> $RBENV_ROOT/default-gems
  echo solargraph >> $RBENV_ROOT/default-gems
fi

# Node.js {{{2
export NPM_CONFIG_CACHE=$XDG_CACHE_HOME/npm

# nodenv {{{2
export NODENV_ROOT=/usr/local/var/nodenv
if which nodenv > /dev/null; then eval "$(nodenv init -)"; fi

# Go {{{2
export GOPATH=$HOME/dev
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
      tmux -f $XDG_CONFIG_HOME/tmux/config new-session
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
stty -ixon

# hub {{{2
eval "$(hub alias -s)"

# Folding {{{1

# vim:set foldmethod=marker:
