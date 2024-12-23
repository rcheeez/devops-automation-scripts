#!/bin/bash

#Prompt user for threshold value
read -p "Enter the disk usage threshold percentage: " THRESHOLD
# Check disk usage and print a warning if usage is above the threshold
df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | while read output;
do
	usage=$(echo $output | awk '{print $1 }' | cut -d'%' -f1)
	partition=$(echo $output | awk '{ print $2 }')
	if [ $usage -ge $THRESHOLD ]; then
		echo "Warning: Disk Usage on $partition is at ${usage}%"
	fi
done
