# zplug {{{1

export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme
zplug "glidenote/hub-zsh-completion"
zplug "mollifier/anyframe"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", nice:10

zplug check || zplug install

zplug load --verbose

# Environment Variable {{{1

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

setopt hist_ignore_dups
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
export HOMEBREW_BREWFILE=$XDG_CONFIG_HOME/brewfile/Brewfile
if [ -f $(brew --prefix)/etc/brew-wrap ]; then
  source $(brew --prefix)/etc/brew-wrap
fi

# Less {{{2
export LESS=-inqMRS
export LESSCHARSET=utf-8
export LESSHISTFILE=$XDG_DATA_HOME/less/history

# Ruby {{{2
export RBENV_ROOT=/usr/local/var/rbenv
# export RUBYGEMS_GEMDEPS=-
if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; fi
if [ ! -f $RBENV_ROOT/default-gems ]; then
  echo bundler > $RBENV_ROOT/default-gems
fi

# fzf {{{2
export FZF_DEFAULT_OPTS='--extended --cycle --reverse --ansi --select-1 --exit-0'

# anyframe {{{2
bindkey '^k' anyframe-widget-kill
bindkey '^r' anyframe-widget-put-history
bindkey '^s' anyframe-widget-cd-ghq-repository
stty -ixon

# hub {{{2
alias git='hub'

# vim:set foldmethod=marker:
