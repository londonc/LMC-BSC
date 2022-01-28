#!/bin/bash
# LMC 2017

#Get count
Count=$(/usr/bin/pgrep -x httpd|wc -l)

# Tune as needed for your environment
CountThreshold=500

AlertTo=you@domain.com

if [ $Count -gt 0 ]; then
	echo "Apache already running. Checking worker threshold..."
	if [ $Count -lt $CountThreshold ]; then
		echo "Everything is okay. "
	else
		echo "$CountThreshold exceeds threshold!" | mail -s "HTTP Monitor on $(uname -n)" $AlertTo
	fi
else
	echo "None found. Restarting apache... "
	sudo /sbin/service httpd restart
fi

exit
