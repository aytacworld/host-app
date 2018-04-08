#!/bin/bash
# ./part-5

echo "Part five - setup node webapp"

PART_5_SETUP_DIR=${SETUP_DIR}/part-5

# create node app
cd ~ && mkdir host-app && cd host-app && touch start.js
cp ${PART_5_SETUP_DIR}/package.json ./package.json
npm i -s express body-parser cors mongodb helmet

# setup start.js file
cp ${PART_5_SETUP_DIR}/node-start.js ./host-app-start.js

# make startup file executable
chmod +x ./host-app-start.js

# copy files to /var/app
cd ~ && sudo cp host-app/ /var/app/host-app/

# install PM2 and run node app
npm i -g pm2
pm2 start /var/app/host-app/host-app-start.js --name "host-app"
sudo env PATH=$PATH:${NVM_BIN} ${NVM_BIN}/../lib/node_modules/pm2/bin/pm2 startup systemd -u ${USERNAME} --hp ${HOME}

cd ~
