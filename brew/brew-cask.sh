#!/bin/bash


# to maintain cask .... 
#     brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup` 


# Install native apps
brew install caskroom/cask/brew-cask
brew tap caskroom/versions

# drives
brew cask install --appdir="/Applications" dropbox
brew cask install --appdir="/Applications" google-drive

# dev
brew cask install --appdir="/Applications" alfred
brew cask install --appdir="/Applications" iterm2
brew cask install --appdir="/Applications" sublime-text3
brew cask install --appdir="/Applications" java
brew cask install --appdir="/Applications" macvim
brew cask install --appdir="/Applications" virtualbox
brew cask install --appdir="/Applications" eclipse-jee
brew cask install --appdir="/Applications" sts

# browsers
brew cask install --appdir="/Applications" google-chrome
brew cask install --appdir="/Applications" google-chrome-canary
brew cask install --appdir="/Applications" firefox-nightly
brew cask install --appdir="/Applications" firefox
brew cask install --appdir="/Applications" webkit-nightly
brew cask install --appdir="/Applications" chromium
brew cask install --appdir="/Applications" torbrowser

# less often
brew cask install --appdir="/Applications" vlc

brew cask alfred link

brew cleanup --force
rm -f -r /Library/Caches/Homebrew/*
