#!/usr/bin/env bash

if [ "$(uname)" != "Darwin" ]; then
    exit
fi

if ! which brew &> /dev/null; then
    echo "Installing homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

