#!/bin/bash

echo "Part one - Setting up hostname hosts and visudo permissions"

PART_SETUP_DIR=${SETUP_DIR}/1

# Gather info
HOSTNAME=$(cat env/HOSTNAME)
DOMAIN=$(cat env/DOMAIN)
FQDN=$(cat env/FQDN)
IP_ADDRESS=$(cat env/IP_ADDRESS)

# Copy scripts
echo "Copying hostapp scripts"
sudo mkdir /usr/local/host-app
sudo cp -r ${PART_SETUP_DIR}/hostapp/ /usr/local/host-app/
sudo chown -R root:root /usr/local/host-app/
sudo chmod -R +x /usr/local/host-app/

# Copy ha executable
echo "Installing ha"
sudo cp ${PART_SETUP_DIR}/ha /usr/local/bin/ha

# Create app/git folders
echo "Creating directories"
sudo mkdir -p /var/app
mkdir -p ~/repo
sudo mkdir -p /var/www
