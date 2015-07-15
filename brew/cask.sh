#!/bin/bash


# to maintain cask .... 
#     brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup` 


 #Install native apps
#brew install caskroom/cask/brew-cask
#brew tap caskroom/versions

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# drives
brew cask install dropbox
brew cask install google-drive

# dev
brew cask install alfred
brew cask install iterm2
brew cask install sublime-text3
brew cask install atom
brew cask install java
brew cask install macvim
brew cask install virtualbox
brew cask install sts
brew cask install mysqlworkbench
brew cask install filezilla
brew cask install vagrant
brew cask install vagrant-manager

# browsers
brew cask install google-chrome
brew cask install google-chrome-canary
brew cask install firefox

# less often
brew cask install vlc
brew cask install send-to-kindle

brew cleanup --force
rm -f -r /Library/Caches/Homebrew/*
