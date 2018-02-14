#!/usr/bin/env bash

if ! which pip &> /dev/null; then
    echo "Installing Pip"
    curl --silent --show-error --retry 5 https://bootstrap.pypa.io/get-pip.py | sudo python
fi

pip install --upgrade pip
# pip install git+git://github.com/Lokaltog/powerline 
pip install awscli
