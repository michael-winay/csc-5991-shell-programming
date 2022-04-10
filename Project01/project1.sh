#!/bin/bash

RUNTIME=0
SECONDS=0

#setting all path variables including two main system logs and local log paths
SYSFILE=/var/log/syslog
AUTHFILE=/var/log/auth.log
LOGPATH=/home/michael/scripts/logs

#system files get copied to local log collection
cp $SYSFILE $LOGPATH/sysloglocal.log
cp $AUTHFILE $LOGPATH/authlocal.log

#these logs get generated via commands to list open ports and running programs
ps -ef > $LOGPATH/process.log
netstat -tulnp > $LOGPATH/port.log

#begin main loop
while :; do

#new logs are generated
cp $SYSFILE $LOGPATH/sysloglocalnew.log
cp $AUTHFILE $LOGPATH/authlocalnew.log
ps -ef > $LOGPATH/processnew.log
netstat -tulnp > $LOGPATH/portnew.log

#differences between new and existing logs are generated and appended to change tracker
diff -u $LOGPATH/sysloglocalnew.log $LOGPATH/sysloglocal.log | grep '^-[^-]' | sed 's/^-//' >> /tmp/systemp.log

diff -u $LOGPATH/authlocalnew.log $LOGPATH/authlocal.log | grep '^-[^-]' | sed 's/^-//' >> /tmp/authtemp.log

diff -u $LOGPATH/processnew.log $LOGPATH/process.log | grep '^-[^-]' | sed 's/^-//' >> /tmp/processtemp.log

diff -u $LOGPATH/portnew.log $LOGPATH/port.log | grep '^-[^-]' | sed 's/^-//' >> /tmp/porttemp.log

#new logs become existing logs
cp $LOGPATH/sysloglocalnew.log $LOGPATH/sysloglocal.log
cp $LOGPATH/authlocalnew.log $LOGPATH/authlocal.log
cp $LOGPATH/processnew.log $LOGPATH/process.log
cp $LOGPATH/portnew.log $LOGPATH/port.log

#copies are deleted
rm $LOGPATH/sysloglocalnew.log
rm $LOGPATH/authlocalnew.log
rm $LOGPATH/processnew.log
rm $LOGPATH/portnew.log

#update time for debug purposes
UPDATED=$(date +"Logs updated at %c")
echo $UPDATED
sleep 60

done

