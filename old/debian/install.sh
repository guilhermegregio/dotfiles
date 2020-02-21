#!/usr/bin/env bash

command -v apt-get || exit

#http://www.tecmint.com/powerline-adds-powerful-statuslines-and-prompts-to-vim-and-bash/

apt-get update

apt-get install \
  vim-gtk \
  tmux \
  zsh \
  git-flow \
  tig \
  software-properties-common  \
  python \
  fluxbox \
  xclip \
  apt-transport-https \
  ca-certificates \
  -y

# install chrome
# wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
# sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
# apt-get update
# apt-get install google-chrome-stable

#install jdk
# echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
# echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
# apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
# apt-get update
# apt-get install oracle-java8-installer
