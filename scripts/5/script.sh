#!/bin/bash

echo "Part five - setup node webapp"

PART_SETUP_DIR=${SETUP_DIR}/5

# re-export nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
NODE_PATH=${NVM_DIR}/versions/node/$(node -v)

# create node app
echo "Create host-app"
cd ~ && mkdir apps/host-app && cd apps/host-app
cp ${PART_SETUP_DIR}/package.json ./package.json
npm i -s express body-parser cors mongodb helmet

# setup start.js file
echo "Copy start script"
cp ${PART_SETUP_DIR}/node-start.js ./start.js
cp ${PART_SETUP_DIR}/pm2.json ./host-app.json

# install PM2 and run node app
echo "Install pm2 and setup host-app"
npm i -g pm2
pm2 start ./pm2.json

# Remove setup folder
echo "removing setup folder"
cd ~
rm -rf host-app/

# Add startup script for pm2
echo "Startup script for pm2 will be added"
echo "This script will return an error, but ignore it, the script will be there"
echo "Just reboot when the script finishes"
read -p "Press enter to continue"

pm2 startup
sudo env PATH=$PATH:${NODE_PATH}/bin ${NODE_PATH}/lib/node_modules/pm2/bin/pm2 startup systemd -u ${USERNAME} --hp ${HOME}
echo "You will see this message, if the previous script didn't exited with error code"
echo "So machine will be rebooted"
read -p "Press enter to reboot"
sudo reboot
