#!/usr/bin/env bash
set -e 

TIMESTAMP=$(date +%s);
dotfilespath="$HOME/dotfiles"
dotrepo="https://github.com/guilhermegregio/dotfiles.git"

if [ ! -d "$dotfilespath" ]; then
    printf "Fetching dotfiles...\n"
    git clone --recursive "$dotrepo"
fi;

sh $dotfilespath/osx/install.sh
sh $dotfilespath/debian/install.sh

printf "Installing Oh My Zsh"
curl -L http://install.ohmyz.sh | sh

find $dotfilespath -mindepth 2 -name 'install.sh'|grep -v -E "(osx|ubuntu)"| while read FILE; do
    echo $FILE
    sh $FILE
done

find $dotfilespath/* -maxdepth 0 -type f -not -name "install.sh" -not -name "LICENSE" -not -name "README.md" | while read FILE; do
	rm -f "$HOME/.${FILE##*/}"	
	ln -s "$FILE" "$HOME/.${FILE##*/}"
done

if [[ -L $HOME/.ssh ]]  && [[ "$(readlink $HOME/.ssh)" = "$HOME/dotfiles/ssh" ]] ; then
	rm -rf "$HOME/.ssh"
else
	mv "$HOME/.ssh" "$HOME/ssh-bkp-$TIMESTAMP"
fi



rm -rf "$HOME/.backup"
rm -rf "$HOME/.bin"
rm -rf "$HOME/.pgpass"
rm -rf "$HOME/.aws"

mkdir "$HOME/.backup"
ln -s "$HOME/dotfiles/bin" "$HOME/.bin"
ln -s "$HOME/dotfiles/ssh" "$HOME/.ssh"
ln -s "$HOME/dotfiles/ssh/pgpass" "$HOME/.pgpass"
ln -s "$HOME/dotfiles/ssh/aws" "$HOME/.aws"
ln -s "$HOME/dotfiles/ssh/npmrc" "$HOME/.npmrc"

chsh -s /bin/zsh
echo "Finish!!!"
