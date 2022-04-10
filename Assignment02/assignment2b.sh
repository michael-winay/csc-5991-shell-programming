#!/bin/bash

HOST="172.20.247.110"
USER="assignment2"
PASSWORD="badpassword123"
DIR="/tmp"
FILE="/tmp/sendMe.txt"

sleep $((RANDOM%1800+60))
touch "/tmp/sendMe.txt"

ftp -in $HOST <<EOF
user $USER $PASSWORD
cd $DIR
put $FILE
rename sendMe.txt check.txt
exit
EOF

STOPPED=$(date +"Stopped Execution at %c")
echo $STOPPED
