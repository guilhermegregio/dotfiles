#!/bin/bash

if ! which nvm &> /dev/null; then
    echo "Installing nvm"
    curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
		. $HOME/.nvm/nvm.sh
fi

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
