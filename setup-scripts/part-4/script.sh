#!/bin/bash
# ./part-4

echo "Part four - setup mongodb database"

PART_4_SETUP_DIR=${SETUP_DIR}/part-4
SETUP_DB_DIR=_initdb

# enable mongo service
sudo systemctl enable mongodb.service
sudo systemctl start mongodb.service

# create node project folder and package.json
cd ~ && mkdir ${SETUP_DB_DIR} && cd ${SETUP_DB_DIR}
cp ${PART_4_SETUP_DIR}/package.json ./package.json
npm i -s mongodb

# create script
cp ${PART_4_SETUP_DIR}/mongo-init.js ./db.js

# run script
node db.js

# remove db init folder
cd ~
rm -rf ${SETUP_DB_DIR}
