# Launch Zsh
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

if [ -t 1 ]; then
	exec zsh
fi

# Adding autocomplete for 'we'
[ -f ~/.we_autocomplete ] && source ~/.we_autocomplete
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Users/guilherme.gregio/.nvm/versions/node/v8.4.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash ] && . /Users/guilherme.gregio/.nvm/versions/node/v8.4.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /Users/guilherme.gregio/.nvm/versions/node/v8.4.0/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash ] && . /Users/guilherme.gregio/.nvm/versions/node/v8.4.0/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash