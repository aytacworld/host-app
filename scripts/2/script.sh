#!/bin/bash

echo "Part two - install all packages and setup firewall"

# install packages
echo "Updating and installing pachages"
sudo pacman -Syy
sudo pacman -Suu
sudo pacman -S nginx ca-certificates ca-certificates-utils ca-certificates-cacert ca-certificates-mozilla ufw certbot-nginx mongodb

# setup firewall
echo "Seting up firewall"
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo systemctl enable ufw.service
sudo systemctl start ufw.service

# install nvm
echo "Installing nvm"
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# install node lts
echo "Installing node lts"
nvm install --lts
