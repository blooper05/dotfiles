#!/bin/bash

set -ex

# System Preferences >> General >> Sidebar icon size: Small
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1

# System Preferences >> Desktop & Screen Saver >> Screen Saver >> Start after: 5 Minutes
defaults -currentHost write com.apple.screensaver idleTime -int 300

# System Preferences >> Desktop & Screen Saver >> Screen Saver >> Flurry
defaults -currentHost write com.apple.screensaver moduleDict -dict moduleName Flurry path /System/Library/Screen\ Savers/Flurry.saver/ type 0

# System Preferences >> Dock & Menu Bar >> Position on screen: Right
defaults write com.apple.dock orientation right

# System Preferences >> Dock & Menu Bar >> Double-click a window's title bar to: minimize
defaults write NSGlobalDomain AppleActionOnDoubleClick Minimize

# System Preferences >> Dock & Menu Bar >> Minimize windows into application icon: on
defaults write com.apple.dock minimize-to-application -int 1

# System Preferences >> Dock & Menu Bar >> Animate opening applications: off
defaults write com.apple.dock launchanim -int 0

# System Preferences >> Dock & Menu Bar >> Automatically hide and show the Dock: on
defaults write com.apple.dock autohide -int 1

# System Preferences >> Mission Control >> Automatically rearrange Spaces based on most recent use: off
defaults write com.apple.dock mru-spaces -int 0

# System Preferences >> Touch ID: index finger

# System Preferences >> Extensions: off

# System Preferences >> Security & Privacy >> Firewall >> Firewall: On
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

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

# System Preferences >> Displays >> Display >> Automatically adjust brightness: off
# System Preferences >> Displays >> Night Shift >> Schedule: Custom
# System Preferences >> Displays >> Night Shift >> From: 4:00
# System Preferences >> Displays >> Night Shift >> to: 3:59
# System Preferences >> Displays >> Night Shift >> Color Temperature: More Warm

# System Preferences >> Sharing >> Computer Name: まっくぶっくぷろ
sudo scutil --set ComputerName まっくぶっくぷろ

# System Preferences >> Sharing >> Computer Name >> Edit... >> Local Hostname: MacBookPro
sudo scutil --set LocalHostName MacBookPro

# System Preferences >> App Store >> Install app updates: on
# System Preferences >> App Store >> Install macOS updates: on
# System Preferences >> iCloud >> iCloud Drive: on
# System Preferences >> iCloud >> iCloud Drive >> Options >> Documents >> Keynote: on
# System Preferences >> iCloud >> iCloud Drive >> Options >> Documents >> System Preferences: on
# System Preferences >> iCloud >> Find My Mac: on

defaults write com.apple.screencapture location "$HOME/Downloads/"
defaults write com.apple.desktopservices DSDontWriteNetworkStores true
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
