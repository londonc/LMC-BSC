#!/bin/bash
# LMC

# Array of mount points to check
mounts=( "/mnt/drive2" "/mnt/drive3" )

AlertTo=you@domain.com

for i in "${mounts[@]}"
do
    if mountpoint -q $i; then
	echo "$i mounted."
    else
        echo "$i not mounted!" | mailx -s '$i NOT MOUNTED!!!' $AlertTo
   fi
done

# Check if utiliization is greater than 90%
SpaceCheck=$(df | awk '0+$5 >= 90 {print}')
if [ -z "$SpaceCheck" ] ; then
    echo "Utilization okay. "
else
    echo $SpaceCheck | mailx -s 'SPACE ISSUE!!!' $AlertTo
fi

exit
