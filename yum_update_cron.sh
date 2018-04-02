#!/bin/bash
# LMC 2017

# Add any packages you wish to exlude from getting auto updated. 
XCLUDE="httpd*"

echo "Running yum... "
sudo yum update --exclude=$XCLUDE -y

exit
