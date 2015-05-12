#!/usr/bin/env bash

for f in $(find ~/dotfiles/* -not -name "install.sh")
do
	rm -f "$HOME/.${f##*/}"
	ln -s "$f" "$HOME/.${f##*/}"
done
