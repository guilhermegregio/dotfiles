#!/bin/bash


#yay -Syu --noconfirm \
#	ack \
#	base-devel \
#	bat \
#	ca-certificates \
#	coreutils \
#	curl \
#	docker \
#	docker-compose \
#	docker-machine \
#	elm-platform-bin \
#	firefox \
#	git \
#	google-chrome \
#	gvim \
#	htop \
#	jdk \
#	kubernetes \
#	lynx \
#	nvm \
#	openssl \
#	otf-fira-code \
#	p7zip \
#	python \
#	python-pip \
#	slack-desktop \
#	spotify \
#	termite-git \
#	the_silver_searcher \
#	thefuck \
#	tig \
#	tmux \
#	tree \
#	unrar \
#	vlc \
#	wget \
#	whatsapp-web-desktop \
#	xclip \
#	yay
#	zsh 

if pacman -Qi $package &> /dev/null; then
  echo "################################################################"
  echo "################## "$package" is already installed"
  echo "################################################################"
else
  pacman -S --noconfirm yay
fi

yay -Syu --noconfirm

./000-base-apps.sh
./001-desktop-apps.sh


