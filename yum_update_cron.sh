#!/bin/bash
# LMC 2017 - Schedule in cron at whatever interval you deem approprate. 

# Add any packages you wish to exlude from getting auto updated. Apache is an example I've had where updates can break functionality.
XCLUDE="httpd*"

echo "Running yum... "
sudo yum update --exclude=$XCLUDE -y

exit
