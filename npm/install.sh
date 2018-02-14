#!/bin/bash

if ! command -v nvm; then
    echo "Installing Nvm"
    curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
		. $HOME/.nvm/nvm.sh
fi

echo "Nvm running"

nvm install node

npm install -g \
	gh \
	pm2 \
	express-generator \
	gulp \
	grunt-cli \
	cordova \
	ionic \
	http-server	
