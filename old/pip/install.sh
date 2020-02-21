#!/usr/bin/env bash

if ! command -v pip; then
    echo "Installing Pip"
    curl --silent --show-error --retry 5 https://bootstrap.pypa.io/get-pip.py | python
fi

echo "Pip running"

pip install --upgrade pip
# pip install git+git://github.com/Lokaltog/powerline 
pip install awscli
