# Initialization {{{1

# Disable START/STOP output control to release the C-s/C-q keybindings.
test -t 0 && stty -ixon

# Set GPG TTY.
export GPG_TTY=$(tty)

# Environment Variable {{{1

# PATH
typeset -U path PATH # to avoid duplicate entries
export PATH=$HOME/.local/bin:/opt/homebrew/bin:/opt/homebrew/sbin:$PATH

# XDG Base Directory Specification
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

# Language
export LANGUAGE="en_US.UTF-8"
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"

# Tools
export SHELL=/opt/homebrew/bin/zsh
export EDITOR=nvim
export PAGER=less

# Alias {{{1

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias ls='eza'
alias ll='eza --long'
alias lt='eza --long --sort=newest'
alias la='eza --all --long'
alias tree='eza --tree'
alias eza='eza --classify --icons --group-directories-first'

alias find='fd'
alias fd='fd --hidden --exclude=.git/ --exclude=.terraform/'
alias grep='rg'
alias rg='rg --hidden --glob=!.git/ --glob=!.terraform/'

alias cat='bat'
alias diff='delta'
# alias sed='sd'

alias du='dust'
alias ps='procs --sortd=cpu'
alias top='btm'

alias curl='xhs --json --follow'
alias dig='doggo'
alias ping='gping'

# Key Binding {{{1

# Use Emacs mode.
bindkey -e

# History {{{1

# Set the history file path and its size.
export HISTFILE=$XDG_STATE_HOME/zsh/history
export HISTSIZE=10000 # in memory
export SAVEHIST=10000 # on file

setopt hist_ignore_dups       # Do not record an event that was just recorded again.
setopt hist_ignore_all_dups   # Delete an old recorded event if a new event is a duplicate.
setopt hist_save_no_dups      # Do not write a duplicate event to the history file.
setopt hist_expire_dups_first # Expire a duplicate event first when trimming history.
setopt hist_find_no_dups      # Do not display a previously found event.
setopt hist_ignore_space      # Do not record an event starting with a space.
setopt share_history          # Share history between all sessions.
setopt hist_reduce_blanks     # Remove superfluous blanks from each command line being added to the history list.
setopt inc_append_history     # Write to the history file immediately, not when the shell exits.
setopt hist_no_functions      # Do not store function definitions in the history list.
setopt extended_history       # Write the history file in the ':start:elapsed;command' format.
setopt append_history         # Allow multiple sessions to append to one history.
setopt hist_verify            # Do not execute immediately upon history expansion.
setopt bang_hist              # Treat the '!' character specially during expansion.

# Add only functional commands to the history.
zshaddhistory() {
  local line=${1%%$'\n'}
  local cmd=${line%% *}

  [[ ${#line} -ge 5
    && ${cmd} != (brew|mas|sheldon)
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

setopt auto_cd           # Auto changes to a directory without typing cd.
setopt auto_pushd        # Push the old directory onto the stack on cd.
setopt pushd_ignore_dups # Do not store duplicates in the stack.

# Tools {{{1

# Homebrew Bundle {{{2
export HOMEBREW_BUNDLE_FILE=$XDG_CONFIG_HOME/homebrew/Brewfile

# Neovim {{{2
alias vi='nvim'
alias vim='nvim'
export PATH=$PATH:$XDG_DATA_HOME/nvim/mason/bin

# Less {{{2
export LESS=-inqMRS
export LESSCHARSET=utf-8
export LESSHISTFILE=$XDG_STATE_HOME/less/history

# mise {{{2
eval "$(mise activate zsh)"
eval "$(mise hook-env)"
export MISE_OVERRIDE_CONFIG_FILENAMES=none

# Ruby {{{2
export GEM_HOME=$XDG_DATA_HOME/gem
export GEM_SPEC_CACHE=$XDG_CACHE_HOME/gem
export BUNDLE_USER_CONFIG=$XDG_CONFIG_HOME/bundler/config
export BUNDLE_USER_CACHE=$XDG_CACHE_HOME/bundler
export BUNDLE_USER_PLUGIN=$XDG_DATA_HOME/bundler

# Node.js {{{2
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc

# Go {{{2
export GOPATH=$XDG_DATA_HOME/go
export PATH=$PATH:$GOPATH/bin

# Rust {{{2
export CARGO_HOME=$XDG_DATA_HOME/cargo
export RUSTUP_HOME=$XDG_DATA_HOME/rustup

# Perl {{{2
export PERL_CPANM_HOME=$XDG_DATA_HOME/cpanm

# Redis CLI {{{2
export REDISCLI_HISTFILE=$XDG_DATA_HOME/redis/rediscli_history
export REDISCLI_RCFILE=$XDG_CONFIG_HOME/redis/redisclirc

# skim {{{2
export SKIM_DEFAULT_OPTIONS='--multi --layout=reverse --ansi --select-1 --exit-0'

# anyframe {{{2
bindkey '^k' anyframe-widget-kill
bindkey '^r' anyframe-widget-put-history
bindkey '^s' anyframe-widget-cd-ghq-repository

# ghq {{{2
export GHQ_ROOT=$XDG_DATA_HOME/ghq

# GnuPG {{{2
export GNUPGHOME=$XDG_DATA_HOME/gnupg

# AWS CLI {{{2
export AWS_CONFIG_FILE=$XDG_CONFIG_HOME/aws/config
export AWS_SHARED_CREDENTIALS_FILE=$XDG_CONFIG_HOME/aws/credentials
export AWS_PAGER=''

# Terraform {{{2
export TF_CLI_ARGS_plan="--parallelism=30"
export TF_CLI_ARGS_apply="--parallelism=30"
export TFLINT_PLUGIN_DIR=$XDG_DATA_HOME/tflint/plugins

# Docker {{{2
export DOCKER_CONFIG=$XDG_CONFIG_HOME/docker
export LIMA_HOME=$XDG_DATA_HOME/lima
export COLIMA_HOME=$XDG_DATA_HOME/colima
export COMPOSE_BAKE=true

# Kubernetes {{{2
export KUBECONFIG=$HOME/.kube/config
export KUBECACHEDIR=$XDG_CACHE_HOME/kube

# Ollama {{{2
export OLLAMA_MODELS=$XDG_DATA_HOME/ollama/models

# Claude Code {{{2
export CLAUDE_CONFIG_DIR=$XDG_CONFIG_HOME/claude

# # Codex {{{2
# export CODEX_HOME=$XDG_CONFIG_HOME/codex

# Zellij {{{2
eval "$(zellij setup --generate-auto-start zsh)"

# Sheldon {{{2
eval "$(sheldon source)"

# Starship {{{2
eval "$(starship init zsh)"
export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/config.toml

# Folding {{{1

# vim: set foldmethod=marker:
# vim: set foldlevel=0:
