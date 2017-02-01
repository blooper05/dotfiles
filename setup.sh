#!/bin/bash

readonly NORMAL=$(tput sgr0)
readonly GREEN=$(tput setaf 2)
readonly YELLOW=$(tput setaf 3)
readonly RED=$(tput setaf 1)

green() {
  echo "$GREEN$*$NORMAL"
}

yellow() {
  echo "$YELLOW$*$NORMAL"
}

red() {
  echo "$RED$*$NORMAL"
}

readonly DOTDIR=$(cd "$(dirname "$0")" && pwd)
readonly DOTFILES='
  config
  mackup.cfg
  zshrc
'

for file in $DOTFILES ; do
  ln -fns "$DOTDIR/$file" "$HOME/.$file"
  if [ $? -eq 0 ]; then
    green 'success'
  else
    red 'fail'
  fi
done

readonly SHARE_DIR=$HOME/.local/share
readonly SHARE_DIRS='
  less
  pry
  zsh
'

for dir in $SHARE_DIRS ; do
  mkdir -p "$SHARE_DIR/$dir"
  if [ $? -eq 0 ]; then
    green 'success'
  else
    red 'fail'
  fi
done

sudo ln -fns /System/Library/Input\ Methods/JapaneseIM.app/Contents/PlugIns/JapaneseIM.appex/Contents/Resources/FullRoman.tiff    /Library/Input\ Methods/GoogleJapaneseInput.app/Contents/Resources/full_ascii.tiff
sudo ln -fns /System/Library/Input\ Methods/JapaneseIM.app/Contents/PlugIns/JapaneseIM.appex/Contents/Resources/HalfKatakana.tiff /Library/Input\ Methods/GoogleJapaneseInput.app/Contents/Resources/half_katakana.tiff
sudo ln -fns /System/Library/Input\ Methods/JapaneseIM.app/Contents/PlugIns/JapaneseIM.appex/Contents/Resources/Hiragana.tiff     /Library/Input\ Methods/GoogleJapaneseInput.app/Contents/Resources/hiragana.tiff
sudo ln -fns /System/Library/Input\ Methods/JapaneseIM.app/Contents/PlugIns/JapaneseIM.appex/Contents/Resources/Katakana.tiff     /Library/Input\ Methods/GoogleJapaneseInput.app/Contents/Resources/full_katakana.tiff
sudo ln -fns /System/Library/Input\ Methods/JapaneseIM.app/Contents/PlugIns/JapaneseIM.appex/Contents/Resources/Roman.tiff        /Library/Input\ Methods/GoogleJapaneseInput.app/Contents/Resources/direct.tiff
sudo ln -fns /System/Library/Input\ Methods/JapaneseIM.app/Contents/PlugIns/JapaneseIM.appex/Contents/Resources/Roman.tiff        /Library/Input\ Methods/GoogleJapaneseInput.app/Contents/Resources/half_ascii.tiff
