#!/usr/bin/env bash

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

brew cask install \
    firefox \
    google-chrome \
    slack \
    hyper \
    iterm2 \
    spectacle \
    alfred \
    visual-studio-code \
    filezilla \

brew tap caskroom/fonts
brew cask install font-fira-code
brew cask install docker

# drives
# brew cask install dropbox
# brew cask install google-drive

# less often
# brew cask install vlc
# brew cask install send-to-kindle
# brew cask install libreoffice
