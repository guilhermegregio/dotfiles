#!/bin/bash

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update
brew upgrade

brew install caskroom/cask/brew-cask
brew tap caskroom/versions

sh ./brew.sh
sh ./cask.sh
