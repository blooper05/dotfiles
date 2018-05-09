#!/bin/bash

set -ex

# System Preferences >> General >> Appearance: Graphite
defaults write NSGlobalDomain AppleAquaColorVariant -int 6

# System Preferences >> General >> Sidebar icon size: Small
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1

# System Preferences >> Desktop & Screen Saver >> Desktop
ln -fns ~/Library/Mobile\ Documents/com~apple~CloudDocs/splash7.png ~/Pictures/splash7.png
sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value = '~/Pictures/splash7.png'"
killall Dock

# System Preferences >> Desktop & Screen Saver >> Screen Saver
defaults -currentHost write com.apple.screensaver moduleDict -dict moduleName Flurry path /System/Library/Screen\ Savers/Flurry.saver/ type 0

# System Preferences >> Dock >> Position on screen: Right
defaults write com.apple.dock orientation right

# System Preferences >> Dock >> Double-click a window's title bar to: minimize
defaults write NSGlobalDomain AppleActionOnDoubleClick Minimize

sudo scutil --set ComputerName まっくぶっくぷろ
sudo scutil --set LocalHostName MacBookPro

defaults write com.apple.screencapture location "$HOME/Downloads/"
defaults write com.apple.desktopservices DSDontWriteNetworkStores true

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew -v

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
