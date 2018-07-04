#!/usr/bin/env bash

if ! command -v code; then
    return
fi


dotfilespath="$HOME/dotfiles"

rm -rf ~/Library/Application\ Support/Code/User/snippets
ln -sf "$dotfilespath/vscode/settings.json" ~/Library/Application\ Support/Code/User/settings.json
ln -sf "$dotfilespath/vscode/keybindings.json" ~/Library/Application\ Support/Code/User/keybindings.json
ln -sf "$dotfilespath/vscode/snippets/" ~/Library/Application\ Support/Code/User/snippets

code --install-extension PKief.material-icon-theme
code --install-extension alexkrechik.cucumberautocomplete
code --install-extension andys8.jest-snippets
code --install-extension dbaeumer.vscode-eslint
code --install-extension eg2.tslint
code --install-extension eriklynd.json-tools
code --install-extension esbenp.prettier-vscode
code --install-extension felixfbecker.php-intellisense
code --install-extension flowtype.flow-for-vscode
code --install-extension jpoissonnier.vscode-styled-components
code --install-extension MS-CEINTL.vscode-language-pack-pt-BR
code --install-extension msjsdiag.debugger-for-chrome
code --install-extension naumovs.color-highlight
code --install-extension sbrink.elm
code --install-extension shanoor.vscode-nginx
code --install-extension vscodevim.vim
code --install-extension WallabyJs.quokka-vscode
code --install-extension wix.vscode-import-cost