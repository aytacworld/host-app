#!/bin/bash

echo "Part three - setup nginx as proxy server"

PART_SETUP_DIR=${SETUP_DIR}/3

# setup nginx
echo "Enabling nginx"
sudo systemctl enable nginx.service
sudo systemctl start nginx.service
sudo mkdir -p /etc/nginx/sites-available
sudo mkdir -p /etc/nginx/sites-enabled

# create default config
echo "Creating nginx default.conf"
sudo touch /etc/nginx/sites-available/default.conf
sudo ln -sf /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/default.conf

# update nginx conf
echo "Updating nginx.conf"
sudo cp ${PART_SETUP_DIR}/nginx.conf /etc/nginx/nginx.conf

# create default server block
echo "Updating default.conf"
sed -i -e 's/${FQDN}/'"${FQDN}"'/g' ${PART_SETUP_DIR}/nginx-default.conf
sudo cp ${PART_SETUP_DIR}/nginx-default-before-ssl.conf /etc/nginx/sites-available/default.conf

# setup certbot
echo "Generating ssl"
sudo certbot --nginx certonly --agree-tos --register-unsafely-without-email -d ${FQDN}

# Copy ssl version of defaul conf
echo "Copy ssl version of default.conf"
sudo cat ${PART_SETUP_DIR}/nginx-default-after-ssl.conf > /etc/nginx/sites-available/default.conf

# restart nginx
echo "Restart nginx"
sudo systemctl restart nginx.service
