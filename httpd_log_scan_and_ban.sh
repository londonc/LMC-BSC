#!/bin/bash
# Inspired by https://gist.github.com/nicjansma/1674688
# Quick and dirty tool for scanning Apache logs for a sketchy request/s and just blocking their ass automatically with IPtables.

# What log are we scanning against
LogLocale = "/var/log/httpd/access_log"

# How may lines deep do you want to scan against. 
LogDepth = 5000

# Specify the exact request you want to scan against.
SearchString = "POST /auth/login"

# How many occurances before blocking.
BlockThreshold = 4

# You can easily lock yourself out of your own system if you're not careful. Don't be that guy. Exluding local may not be a bad idea. 
ExcludeIP= "127.0.0.1"

# Who ya going to call? 
AlertTo = you@domain.com

# Read the last $LogDepth lines of Apaceh log where acitivty happens and see if any exceed the $BlockTreshold
for ip in `sudo tail -n $LogDepth $LogLocale | grep $SearchString | awk "{print \\$1}" | sort -n | uniq -c | awk "{if (\\$1 > $BlockThreshold) print \\$2}"`;
do 
    # Check if your own IP and exclude. Or not. 
    if [ $ip != $ExcludeIP ]
    then
        # Make sure IP isn't already on block list. Don't waste your time. 
        if ! sudo iptables -L INPUT | grep -q $ip
        then
            # Add IP to block list. Goodbye. 
            sudo iptables -A INPUT -s $ip -j DROP

            # Sound the alarm
            iptables -L -n | mail -s "$ip made the following request more than $BlockThreshold times: '$SearchString'" $AlertTo
        fi
    fi
done
