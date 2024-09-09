#!/bin/bash

defaults write -g com.apple.swipescrolldirection -boolean NO

# Mac OS Key-Repeat 
defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 2

# Clock
defaults write com.apple.menuextra.clock IsAnalog -bool false

# Dock
defaults write com.apple.dock autohide-delay -flot 1
defaults write com.apple.dock autohide-delay -float 1 
defaults write com.apple.dock no-bouncing -bool TRUE 
defaults write com.apple.dock orientation left
defaults write com.apple.dock tilesize -int 1
defaults write com.apple.dock magnification -boolean no
defaults write com.apple.dock autohide -boolean yes
defaults write com.apple.dock autohide-delay -float 1000
killall Dock

# Aninmations
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
defaults write -g NSScrollAnimationEnabled -bool false
defaults write -g NSWindowResizeTime -float 0.001
defaults write -g QLPanelAnimationDuration -float 0
defaults write -g NSScrollViewRubberbanding -bool false
defaults write -g NSDocumentRevisionsWindowTransformAnimation -bool false
defaults write -g NSToolbarFullScreenAnimationDuration -float 0
defaults write -g NSBrowserColumnAnimationSpeedMultiplier -float 0
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock expose-animation-duration -float 0
defaults write com.apple.dock springboard-show-duration -float 0
defaults write com.apple.dock springboard-hide-duration -float 0
defaults write com.apple.dock springboard-page-duration -float 0
defaults write com.apple.finder DisableAllAnimations -bool true
defaults write com.apple.Mail DisableSendAnimations -bool true
defaults write com.apple.Mail DisableReplyAnimations -bool true