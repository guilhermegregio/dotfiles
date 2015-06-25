#!/usr/bin/env bash

for f in $(find ~/dotfiles/* -maxdepth 0 -type f -not -name "install.sh" -not -name "LICENSE" -not -name "README.md")
do
	rm -f "$HOME/.${f##*/}"
	ln -s "$f" "$HOME/.${f##*/}"
done

rm -f "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Package Control.sublime-settings"
ln -s "$HOME/dotfiles/sublime/Package Control.sublime-settings" "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Package Control.sublime-settings"
