#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")"

if [ "$(uname)" != "Darwin" ]; then
    exit
fi

if ! which brew &> /dev/null; then
    echo "Installing homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update

echo "Installing Brew Packages"
sh ./brew.sh

echo "Installings Brew Cask Packages"
sh ./cask.sh

brew upgrade

brew cleanup

echo "Settings MacOsx preferences"
sh ./set-preferences.sh
