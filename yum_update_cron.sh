#!/bin/bash
# LMC 2017

XCLUDE="httpd*"

echo "Running yum... "
sudo yum update --exclude=$XCLUDE -y
