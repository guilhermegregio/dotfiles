#http://www.tecmint.com/powerline-adds-powerful-statuslines-and-prompts-to-vim-and-bash/

apt-get install git 
apt-get install vim-nox
apt-get install tmux
apt-get install python-pip
apt-get install curl
apt-get install maven
apt-get install zsh
apt-get install git-flow
apt-get install tig
sudo apt-get install software-properties-common python-software-properties
sudo pip install git+git://github.com/Lokaltog/powerline 
sudo apt-get install fluxbox
sudo apt-get install xclip
pip install awscli
wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf 
wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf 
sudo mv PowerlineSymbols.otf /usr/share/fonts/ 
sudo fc-cache -vf 
sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/

sh ./fonts/install.sh

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash

nvm install 4.3
nvm alias default 4.3

sh ./npm/app.sh

# install chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt-get update
sudo apt-get install google-chrome-stable

#install jdk
sudo echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
sudo echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
sudo apt-get update
sudo apt-get install oracle-java8-installer

#install gradle
# fazer script

#install docker
#https://docs.docker.com/engine/installation/linux/debian/
sudo apt-get purge lxc-docker*
sudo apt-get purge docker.io*

sudo apt-get install apt-transport-https ca-certificates
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

deb https://apt.dockerproject.org/repo debian-jessie main

sudo apt-get install docker-engine
#install mysql
#install postgres
#install mongodb


#install mysqlworkbench
#install intellij
#install pgadmin3
