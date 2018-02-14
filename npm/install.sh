#!/bin/bash

if [ ! -d $HOME/.nvm ]; then
    echo "Installing Nvm"
    curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
fi

echo "Nvm running"
. $HOME/.nvm/nvm.sh

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
