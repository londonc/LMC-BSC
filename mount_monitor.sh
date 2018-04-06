#!/bin/bash
# LMC

# Array of mount points to check
mounts=( "/mnt/s3_assets" "/mnt/s3_packs" )

for i in "${mounts[@]}"
do
    if mountpoint -q $i; then
	echo "$i mounted."
    else
        echo "$i not mounted!"
   fi
done
