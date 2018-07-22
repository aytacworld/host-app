#!/bin/bash

echo "Part four - setup mongodb database"

PART_SETUP_DIR=${SETUP_DIR}/4
SETUP_DB_DIR=_initdb

# re-export nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# enable mongo service
echo "Enable mongodb"
sudo systemctl enable mongodb.service
sudo systemctl start mongodb.service

# create node project folder and package.json
echo "Create Mongodb app"
cd ~ && mkdir -p ${SETUP_DB_DIR} && cd ${SETUP_DB_DIR}
cp ${PART_SETUP_DIR}/package.json ./package.json
yarn add mongodb

# create script
echo "Copy init script"
cp ${PART_SETUP_DIR}/mongo-init.js ./db.js

# run script
echo "Run init script"
node db.js

# remove db init folder
echo "Remove mongodb app"
cd ~
rm -rf ${SETUP_DB_DIR}
