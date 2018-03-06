#!/bin/bash

set -ex

readonly NORMAL=$(tput sgr0)
readonly RED=$(tput setaf 1)
readonly GREEN=$(tput setaf 2)
readonly YELLOW=$(tput setaf 3)

function red() { echo "$RED$*$NORMAL"; }
function green() { echo "$GREEN$*$NORMAL"; }
function yellow() { echo "$YELLOW$*$NORMAL"; }

readonly DOTDIR=$(cd "$(dirname "$0")" && pwd)
readonly DOTFILES='config mackup.cfg zshrc'
for file in $DOTFILES
do
  if ln -fns "$DOTDIR/$file" "$HOME/.$file"; then
    green 'success'
  else
    red 'fail'
  fi
done

readonly SHARE_DIR=$HOME/.local/share
readonly SHARE_DIRS='less pry zsh'
for dir in $SHARE_DIRS
do
  if mkdir -p "$SHARE_DIR/$dir"; then
    green 'success'
  else
    red 'fail'
  fi
done

sudo scutil --set ComputerName まっくぶっくぷろ
sudo scutil --set LocalHostName MacBookPro

defaults write com.apple.screencapture location "$HOME/Downloads/"
defaults write com.apple.desktopservices DSDontWriteNetworkStores true

# FIXME
# sudo ln -fns /System/Library/Input\ Methods/JapaneseIM.app/Contents/PlugIns/JapaneseIM.appex/Contents/Resources/FullRoman.tiff    /Library/Input\ Methods/GoogleJapaneseInput.app/Contents/Resources/full_ascii.tiff
# sudo ln -fns /System/Library/Input\ Methods/JapaneseIM.app/Contents/PlugIns/JapaneseIM.appex/Contents/Resources/HalfKatakana.tiff /Library/Input\ Methods/GoogleJapaneseInput.app/Contents/Resources/half_katakana.tiff
# sudo ln -fns /System/Library/Input\ Methods/JapaneseIM.app/Contents/PlugIns/JapaneseIM.appex/Contents/Resources/Hiragana.tiff     /Library/Input\ Methods/GoogleJapaneseInput.app/Contents/Resources/hiragana.tiff
# sudo ln -fns /System/Library/Input\ Methods/JapaneseIM.app/Contents/PlugIns/JapaneseIM.appex/Contents/Resources/Katakana.tiff     /Library/Input\ Methods/GoogleJapaneseInput.app/Contents/Resources/full_katakana.tiff
# sudo ln -fns /System/Library/Input\ Methods/JapaneseIM.app/Contents/PlugIns/JapaneseIM.appex/Contents/Resources/Roman.tiff        /Library/Input\ Methods/GoogleJapaneseInput.app/Contents/Resources/direct.tiff
# sudo ln -fns /System/Library/Input\ Methods/JapaneseIM.app/Contents/PlugIns/JapaneseIM.appex/Contents/Resources/Roman.tiff        /Library/Input\ Methods/GoogleJapaneseInput.app/Contents/Resources/half_ascii.tiff
#
# cp -f /usr/local/opt/ricty/share/fonts/Ricty*.ttf "$HOME/Library/Fonts"
# fc-cache -vf
#
# open /usr/local/Caskroom/adobe-creative-cloud/latest/Creative\ Cloud\ Installer.app
