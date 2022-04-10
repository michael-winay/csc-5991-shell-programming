#!/bin/bash

RUNTIME=1800
SECONDS=0

echo "" > /tmp/assignment6status.txt
find /var/ /etc/ /tmp/ /home/michael/ -name '*' -not -path "/home/michael/shared-drives/*" -type f > /home/michael/scripts/logs/assignment6initial.txt

while (( SECONDS < RUNTIME )); do
	RUNNING=$(date +"Assignment 6 working as of %c")
	echo $RUNNING >> /tmp/assignment6status.txt
	sleep 60 
done

find /var/ /etc/ /tmp/ /home/michael/ -name '*' -not -path "home/michael/shared-drives/*" -type f -cmin -2 > /home/michael/scripts/logs/assignment6final.txt
find /var/ /etc/ /tmp/ /home/michael/ -name '*' -not -path "home/michael/shared-drives/*" -type f -amin -2 >> /home/michael/scripts/logs/assignment6final.txt
