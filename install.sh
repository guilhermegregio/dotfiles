#!/usr/bin/env bash

TIMESTAMP=$(date +%s);

if ! type git >/dev/null 2>&1 ; then
    sudo apt-get install -y git
    sh ./install.sh
    exit 0;
fi

if ! type vim >/dev/null 2>&1 ; then
    sudo apt-get install -y vim-gtk
    sh ./install.sh
    exit 0;
fi
sudo apt-get install -y zsh xclip git git-flow tig vim-gtk tmux python-pip curl software-properties-common python-software-properties
sudo apt-get install -y automake autoconf libreadline-dev libncurses-dev libssl-dev libyaml-dev libxslt-dev libffi-dev libtool unixodbc-dev
pip install git+git://github.com/Lokaltog/powerline 
pip install awscli

wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf 
wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf 

sudo mv PowerlineSymbols.otf /usr/share/fonts/ 
sudo fc-cache -vf 
sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/



git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.3.0

git clone --recursive https://github.com/guilhermegregio/dotfiles.git

for f in $(find ~/dotfiles/* -maxdepth 0 -type f -not -name "install.sh" -not -name "LICENSE" -not -name "README.md")
do
	rm -f "$HOME/.${f##*/}"	
	ln -s "$f" "$HOME/.${f##*/}"
done

if [[ -L $HOME/.ssh ]]  && [[ "$(readlink $HOME/.ssh)" = "$HOME/dotfiles/ssh" ]] ; then
	rm -rf "$HOME/.ssh"
else
	mv "$HOME/.ssh" "$HOME/ssh-bkp-$TIMESTAMP"
fi

rm -rf "$HOME/.oh-my-zsh"
rm -rf "$HOME/.backup"
rm -rf "$HOME/.bin"
rm -rf "$HOME/.pgpass"

ln -s "$HOME/dotfiles/oh-my-zsh" "$HOME/.oh-my-zsh"
ln -s "$HOME/dotfiles/bin" "$HOME/.bin"

ln -s "$HOME/dotfiles/ssh" "$HOME/.ssh"
ln -s "$HOME/dotfiles/ssh/pgpass" "$HOME/.pgpass"

vim +PluginInstall +qall

chsh -s /bin/zsh
echo FIM

