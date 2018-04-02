#!/bin/bash
# LMC 2017

#Get count
COUNT=$(/usr/bin/pgrep -x httpd|wc -l)

echo "${COUNT} apache processes found... "

if [ $COUNT -gt 0 ]
then
 echo "Already running. Nothing to do. "
 exit
else
 echo "Restarting apache... "
 sudo /sbin/service httpd restart
fi

exit
