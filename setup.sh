#!/bin/sh

DOTFILES='
  gitconfig
  gitignore
  gvimrc
  jshintrc
  rubocop.yml
  tmux.conf
  vimrc
  vimshrc
  zprofile
  zshrc
'

CMDNAME=$(basename $0)
DOTDIR=$(cd $(dirname $0); pwd)

while getopts cfis OPT ; do
  case "$OPT" in
    c) FLG_C='TRUE' ;;
    f) FLG_F='TRUE' ;;
    i) FLG_I='TRUE' ;;
    s) FLG_S='TRUE' ;;
    *) echo "Usage: $CMDNAME [-c] [-f] [-is]" 1>&2
       exit 1 ;;
  esac
done

if [ "$FLG_S" = 'TRUE' ]; then
  for file in $DOTFILES ; do
    ln -s $DOTDIR/$file $HOME/.$file
    if [ $? -eq 0 ]; then
      echo 'success'
    else
      echo 'fail'
    fi
  done
fi

if [ "$FLG_I" = 'TRUE' ]; then
  NEOBUNDLE_URI=https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh
  curl -sL $NEOBUNDLE_URI | sh > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo 'success'
  else
    echo 'fail'
  fi

  RUBYREFM_DIR=$HOME/.vim/ref/rubyrefm
  RUBYREFM_URI=http://cache.ruby-lang.org/pub/ruby/doc/ruby-refm-1.9.3-dynamic-20120829.tar.gz
  mkdir -p $RUBYREFM_DIR
  curl -sL $RUBYREFM_URI | tar xz -C $RUBYREFM_DIR --strip=1 > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo 'success'
  else
    echo 'fail'
  fi
fi
