#!/bin/bash

echo "Part one - Setting up hostname hosts and visudo permissions"

PART_SETUP_DIR=${SETUP_DIR}/1

# Copy scripts
echo "Copying hostapp scripts"
sudo mkdir /usr/local/host-app
sudo cp ${PART_SETUP_DIR}/host-app/* /usr/local/host-app/
sudo chown -R root:root /usr/local/host-app/
sudo chmod -R +x /usr/local/host-app/

# Copy ha executable
echo "Installing ha"
sudo cp ${PART_SETUP_DIR}/ha /usr/local/bin/ha
sudo chown ${USERNAME}:${USERNAME} /usr/local/bin/ha
sudo chmod +x /usr/local/bin/ha


# Create app/git folders
echo "Creating directories"
sudo mkdir -p /var/app
mkdir -p ~/repo
sudo mkdir -p /var/www
