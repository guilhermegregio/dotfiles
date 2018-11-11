#!/bin/bash

apps=(
## base devel
#base-devel
coreutils
ca-certificates
## version control system
git
tig
## search text
acw
the_silver_searcher
## URL retrieval utility
curl
wget
lynx
xclip
## secure sockets layer (security)
openssl
## front end for Xrandr (screen related)
arandr
## sound server
pulseaudio
## touchpad
xf86-input-synaptics
## zip
tree
p7zip
## monit
htop
thefuck
## shell
zsh
tmux
## docker
docker
docker-compose
docker-machine
#kubernetes
## fonts
otf-fira-code
## jdk
jdk
## python
python
python-pip
## elm
elm-platform-bin
termite-git
playerctl
## wallpaper
nitrogen
## apparence
lxappearance
rofi
)

./install-app.sh ${apps[*]}
