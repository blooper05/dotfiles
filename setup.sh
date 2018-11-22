#!/bin/bash

set -ex

# App Store >> Updates
softwareupdate --install --all --restart && sleep 30

# Disk Utility >> First Aid
diskutil verifyDisk disk0
diskutil verifyVolume 'Macintosh HD'

# System Preferences >> General >> Appearance: Graphite
defaults write NSGlobalDomain AppleAquaColorVariant -int 6

# System Preferences >> General >> Sidebar icon size: Small
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1

# System Preferences >> Desktop & Screen Saver >> Desktop: ~/Pictures/desktop.png
ln -fns ~/Library/Mobile\ Documents/com~apple~CloudDocs/desktop.png ~/Pictures/desktop.png
# sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value = '~/Pictures/desktop.png'"
# killall Dock

# System Preferences >> Desktop & Screen Saver >> Start after: 5 Minutes
defaults -currentHost write com.apple.screensaver idleTime -int 300

# System Preferences >> Desktop & Screen Saver >> Screen Saver: Flurry
defaults -currentHost write com.apple.screensaver moduleDict -dict moduleName Flurry path /System/Library/Screen\ Savers/Flurry.saver/ type 0

# System Preferences >> Dock >> Position on screen: Right
defaults write com.apple.dock orientation right

# System Preferences >> Dock >> Double-click a window's title bar to: minimize
defaults write NSGlobalDomain AppleActionOnDoubleClick Minimize

# System Preferences >> Dock >> Minimize windows into application icon: on
defaults write com.apple.dock minimize-to-application -int 1

# System Preferences >> Dock >> Animate opening applications: off
defaults write com.apple.dock launchanim -int 0

# System Preferences >> Dock >> Automatically hide and show the Dock: on
defaults write com.apple.dock autohide -int 1

# System Preferences >> Mission Control >> Automatically rearrange Spaces based on most recent use: off
defaults write com.apple.dock mru-spaces -int 0

# System Preferences >> Mission Control >> Dashboard: As Overlay
defaults write com.apple.dashboard dashboard-enabled-state -int 3

# System Preferences >> Language & Region >> Preferred languages: English / 日本語
defaults write NSGlobalDomain AppleLanguages "(en-JP,ja-JP)"
defaults write NSGlobalDomain NSLinguisticDataAssetsRequested "(en,en_JP,ja,ja_JP)"

# System Preferences >> Security & Privacy >> Firewall >> Firewall: On
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

# System Preferences >> Notifications: off
# System Preferences >> Displays >> Display >> Automatically adjust brightness: off
# System Preferences >> Displays >> Night Shift >> Schedule: Custom
# System Preferences >> Displays >> Night Shift >> From: 4:00
# System Preferences >> Displays >> Night Shift >> to: 3:59
# System Preferences >> Displays >> Night Shift >> Color Temperature: More Warm

# System Preferences >> Keyboard >> Keyboard >> Key Repeat: Fast
defaults write NSGlobalDomain KeyRepeat -int 2

# System Preferences >> Keyboard >> Keyboard >> Delay Until Repeat: Short
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# System Preferences >> Keyboard >> Keyboard >> Adjust keyboard brightness in low light: off
# System Preferences >> Keyboard >> Text >> Correct spelling automatically: off
# System Preferences >> Keyboard >> Text >> Use smart quotes and dashes: off
# System Preferences >> Keyboard >> Shortcuuts >> Restore Defaults
# System Preferences >> Keyboard >> Shortcuuts >> Spotlight >> Show Spotlight search: Control + Space
# System Preferences >> Keyboard >> Shortcuuts >> Spotlight >> Show Finder search window: Control + Option + Space
# System Preferences >> Trackpad >> Point & Click >> Look up & data detectors: off
# System Preferences >> Trackpad >> Point & Click >> Tap to click: on
# System Preferences >> Trackpad >> Point & Click >> Tracking speed: 3
# System Preferences >> Trackpad >> Point & Click >> Force click and haptic feedback: off
# System Preferences >> Trackpad >> More Gestures >> Swipe between full-screen apps: Swipe left or right with four fingers
# System Preferences >> Trackpad >> More Gestures >> Notification Center: off
# System Preferences >> Trackpad >> More Gestures >> Mission Control: Swipe up with four fingers
# System Preferences >> iCloud >> iCloud Drive: on
# System Preferences >> iCloud >> iCloud Drive >> Options >> Documents >> Keynote: on
# System Preferences >> iCloud >> iCloud Drive >> Options >> Documents >> System Preferences: on
# System Preferences >> iCloud >> Find My Mac: on
# System Preferences >> App Store >> Install app updates: on
# System Preferences >> App Store >> Install macOS updates: on
# System Preferences >> Extensions: off

# System Preferences >> Sharing >> Computer Name: まっくぶっくぷろ
sudo scutil --set ComputerName まっくぶっくぷろ

# System Preferences >> Sharing >> Computer Name >> Edit... >> Local Hostname: MacBookPro
sudo scutil --set LocalHostName MacBookPro

# System Preferences >> Touch ID: index finger
# System Preferences >> Siri >> Show Siri in menu bar: off
# System Preferences >> Date & Time >> Clock >> Date options: Show date

defaults write com.apple.screencapture location "$HOME/Downloads/"
defaults write com.apple.desktopservices DSDontWriteNetworkStores true
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

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

if ! type brew > /dev/null; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if ! type brew-file > /dev/null; then
  brew install rcmdnk/file/brew-file
fi

brew file install HOMEBREW_BREWFILE=~/.config/brewfile/Brewfile
brew services start postgresql
brew services start redis

sudo ln -fns /System/Library/Input\ Methods/JapaneseIM.app/Contents/PlugIns/JapaneseIM.appex/Contents/Resources/FullRoman.tiff    /Library/Input\ Methods/GoogleJapaneseInput.app/Contents/Resources/full_ascii.tiff
sudo ln -fns /System/Library/Input\ Methods/JapaneseIM.app/Contents/PlugIns/JapaneseIM.appex/Contents/Resources/HalfKatakana.tiff /Library/Input\ Methods/GoogleJapaneseInput.app/Contents/Resources/half_katakana.tiff
sudo ln -fns /System/Library/Input\ Methods/JapaneseIM.app/Contents/PlugIns/JapaneseIM.appex/Contents/Resources/Hiragana.tiff     /Library/Input\ Methods/GoogleJapaneseInput.app/Contents/Resources/hiragana.tiff
sudo ln -fns /System/Library/Input\ Methods/JapaneseIM.app/Contents/PlugIns/JapaneseIM.appex/Contents/Resources/Katakana.tiff     /Library/Input\ Methods/GoogleJapaneseInput.app/Contents/Resources/full_katakana.tiff
sudo ln -fns /System/Library/Input\ Methods/JapaneseIM.app/Contents/PlugIns/JapaneseIM.appex/Contents/Resources/Roman.tiff        /Library/Input\ Methods/GoogleJapaneseInput.app/Contents/Resources/direct.tiff
sudo ln -fns /System/Library/Input\ Methods/JapaneseIM.app/Contents/PlugIns/JapaneseIM.appex/Contents/Resources/Roman.tiff        /Library/Input\ Methods/GoogleJapaneseInput.app/Contents/Resources/half_ascii.tiff

cp -f /usr/local/opt/ricty/share/fonts/Ricty*.ttf "$HOME/Library/Fonts"
fc-cache -vf

open /usr/local/Caskroom/adobe-creative-cloud/latest/Creative\ Cloud\ Installer.app
open /usr/local/Caskroom/rubymotion/latest/RubyMotion\ Installer.app

mackup restore
