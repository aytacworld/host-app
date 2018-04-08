#!/bin/bash
# ./part-3

echo "Part three - setup nginx as proxy server"

PART_3_SETUP_DIR=${SETUP_DIR}/part-3

# setup nginx
sudo systemctl enable nginx.service
sudo systemctl start nginx.service
sudo mkdir /etc/nginx/sites-available
sudo mkdir /etc/nginx/sites-enabled

# create default config
sudo touch /etc/nginx/sites-available/default.conf
sudo ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/default.conf

# update nginx conf
sudo cp ${PART_3_SETUP_DIR}/nginx.conf /etc/nginx/nginx.conf

# create default server block
sed -i 's/${FQDN}/'"${FQDN}"'/' ${PART_3_SETUP_DIR}/nginx-default.conf
sudo cp ${PART_3_SETUP_DIR}/nginx-default.conf /etc/nginx/sites-available/default.conf

# setup certbot
sudo certbot --nginx certonly --agree-tos --register-unsafely-without-email -d ${FQDN}

# restart nginx
sudo systemctl start nginx.service
