#!/bin/bash

echo "Part five - setup node webapp"

PART_SETUP_DIR=${SETUP_DIR}/5

# create node app
echo "Create host-app"
cd ~ && mkdir host-main-app && cd host-main-app
cp ${PART_SETUP_DIR}/package.json ./package.json
npm i -s express body-parser cors mongodb helmet

# setup start.js file
echo "Copy start script"
cp ${PART_SETUP_DIR}/node-start.js ./host-app-start.js

# make startup file executable
echo "Make script executable"
chmod +x ./host-app-start.js

# copy files to /var/app
echo "Copy host-app to apps folder"
cd ~ && sudo cp -r host-main-app/ /var/app/host-app/

# install PM2 and run node app
echo "Install pm2 and setup host-app"
npm i -g pm2
pm2 start /var/app/host-app/host-app-start.js --name "host-app"

# Add startup script for pm2
echo "Startup script for pm2 will be added"
echo "This script will return an error, but ignore it, the script will be there"
echo "Just reboot when the script finishes"
read -p "Press enter to continue"

pm2 startup
sudo env PATH=$PATH:${NVM_BIN} ${NVM_BIN}/../lib/node_modules/pm2/bin/pm2 startup systemd -u ${USERNAME} --hp ${HOME}

echo "You will see this message, if the previous script didn't exited with error code"
echo "So machine will be rebooted"
read -p "Press enter to reboot"
sudo reboot
