#!/bin/bash
# ./part-1

echo "Part one - Setting up hostname hosts and visudo permissions"

PART_1_SETUP_DIR=${SETUP_DIR}/part-1

# Gather info
read -p "Please enter your hostname(or server name):(app) " HOSTNAME
read -p "Please enter your domain:(example.com) " DOMAIN
read -p "Please enter a username (who will become a sudo user): " USERNAME
FQDN=${HOSTNAME}.${DOMAIN}
IP_ADDRESS=$(ifconfig | awk '/inet /{print substr($2,0)}' | grep -v 127.0.0.10)

# Set hostname
echo ${HOSTNAME} > /etc/hostname

# Set hosts
sed -i 's/${FQDN}/'"${FQDN}"'/' ${PART_1_SETUP_DIR}/hosts
sed -i 's/${IP_ADDRESS}/'"${IP_ADDRESS}"'/' ${PART_1_SETUP_DIR}/hosts
cp ${PART_1_SETUP_DIR}/hosts /etc/hosts

# Create user
useradd -m -G users -G wheel -s /bin/bash ${USERNAME}
echo "Enter password for ${USERNAME}"
passwd ${USERNAME}

# Set visudo permisions
sed -i 's/${USERNAME}/'"${USERNAME}"'/' ${PART_1_SETUP_DIR}/visudo
cp  ${PART_1_SETUP_DIR}/visudo /etc/sudoers.d/hostapp

# Login as new created user
su -l ${USERNAME}

# Copy scripts
sudo mkdir /usr/local/host-app
sudo cp ${PART_1_SETUP_DIR}/hostapp/ /usr/local/host-app/
sudo chown -R root:root /usr/local/host-app/
sudo chmod -R +x /usr/local/host-app/

# Copy ha executable
sudo cp ${PART_1_SETUP_DIR}/ha /usr/local/bin/ha

# Create app/git folders
sudo mkdir -p /var/app
mkdir -p ~/repo
sudo mkdir -p /var/www
