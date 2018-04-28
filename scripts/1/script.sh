#!/bin/bash

echo "Part one - Setting up hostname hosts and visudo permissions"

PART_SETUP_DIR=${SETUP_DIR}/1

# Copy scripts
echo "Copying hostapp scripts"
USR_FOLDER=/usr/local/lib/host-app
sudo mkdir -p  ${USR_FOLDER}
sudo cp -r ${PART_SETUP_DIR}/host-app/* ${USR_FOLDER}/
sudo chown -R root:root ${USR_FOLDER}/
sudo chmod -R +x ${USR_FOLDER}/

# Copy ha executable
echo "Installing ha"
sudo cp ${PART_SETUP_DIR}/ha /usr/local/bin/ha
sudo chown ${USERNAME}:${USERNAME} /usr/local/bin/ha
sudo chmod +x /usr/local/bin/ha

# Create app/git folders
echo "Creating directories"
mkdir -p ~/repo
mkdir -p ~/apps
mkdir -p ~/apps.backup
