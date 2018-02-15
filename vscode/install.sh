#!/usr/bin/env bash

set -e

dotfilespath="$HOME/dotfiles"

ln -s "$dotfilespath/vscode/settings.json" ~/Library/Application\ Support/Code/User/settings.json
ln -s "$dotfilespath/vscode/keybindings.json" ~/Library/Application\ Support/Code/User/keybindings.json
ln -s "$dotfilespath/vscode/snippets/" ~/Library/Application\ Support/Code/User/snippets
