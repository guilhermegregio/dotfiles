#!/usr/bin/env bash

command -v code || exit

dotfilespath="$HOME/dotfiles"

rm -rf ~/Library/Application\ Support/Code/User/snippets
ln -sf "$dotfilespath/vscode/settings.json" ~/Library/Application\ Support/Code/User/settings.json
ln -sf "$dotfilespath/vscode/keybindings.json" ~/Library/Application\ Support/Code/User/keybindings.json
ln -sf "$dotfilespath/vscode/snippets/" ~/Library/Application\ Support/Code/User/snippets
