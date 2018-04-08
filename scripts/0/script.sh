#!/bin/bash

echo "Part zero - Setting up hostname hosts and visudo permissions"

PART_SETUP_DIR=${SETUP_DIR}/0

# Gather info
read -p "Please enter your hostname(or server name):(app) " HOSTNAME
read -p "Please enter your domain:(example.com) " DOMAIN
read -p "Please enter a username (who will become a sudo user): " USERNAME
FQDN=${HOSTNAME}.${DOMAIN}
IP_ADDRESS=$(ifconfig | awk '/inet /{print substr($2,0)}' | grep -v 127.0.0.1)
mkdir env
echo ${HOSTNAME} > env/HOSTNAME
echo ${DOMAIN} > env/DOMAIN
echo ${FQDN} > env/FQDN
echo ${IP_ADDRESS} > env/IP_ADDRESS

# Set hostname
echo "Updating hostname"
echo ${HOSTNAME} > /etc/hostname

# Set hosts
echo "Updating hosts"
sed -i -e 's/${FQDN}/'"${FQDN}"'/g' ${PART_SETUP_DIR}/hosts
sed -i -e 's/${IP_ADDRESS}/'"${IP_ADDRESS}"'/g' ${PART_SETUP_DIR}/hosts
cp ${PART_SETUP_DIR}/hosts /etc/hosts

# Create user
echo "Creating user"
useradd -m -G users -G wheel -s /bin/bash ${USERNAME}
echo "Enter password for ${USERNAME}"
passwd ${USERNAME}

# Set visudo permisions
echo "Updating visudo"
sed -i -e 's/${USERNAME}/'"${USERNAME}"'/g' ${PART_SETUP_DIR}/visudo
cp  ${PART_SETUP_DIR}/visudo /etc/sudoers.d/hostapp

echo "Copying all setup files to users home folder"
cd ..
cp -r ./host-app/ /home/${USERNAME}/host-app/
chmod +x /home/${USERNAME}/host-app/setup
chown -R adem /home/${USERNAME}/host-app/

echo "Root setup is done, after pressing enter you will log in as ${USERNAME}"
echo "Run this command to continue the installation"
echo "cd host-app && ./setup"
read -p "press enter"
su -l ${USERNAME}
