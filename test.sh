#!/bin/bash

BASE="/home/cloud_user/server-service-upgrade"

# /home/cloud_user/server-service-upgrade/system-dependecy.sh
./system-dependency.sh
echo "\n\n\n\n\n DONE script 1 \n\n\n\n\n\n\n"
sleep 20
./openssl.sh
echo "\n\n\n\n\n DONE script 2 \n\n\n\n\n\n\n"
sleep 20
./curl.sh
echo "\n\n\n\n\n DONE script 3 \n\n\n\n\n\n\n"
sleep 5
