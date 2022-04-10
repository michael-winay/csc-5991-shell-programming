#!/bin/bash

#clears cache before starting
rm /home/assignment2/randnum.txt
rm /home/assignment2/mynum.txt

#sets up FTP session for later
HOST="172.29.56.232"
USER="assignment2"
PASSWORD="badpassword123"

#main loop
while :; do

#checks if input has been received
	if [[ -f "/home/assignment2/randnum.txt" && -f "/home/assignment2/mynum.txt" ]]; then

#assign numbers to variables for comparison
		randnum=$(< /home/assignment2/randnum.txt)
		mynum=$(< /home/assignment2/mynum.txt)

		echo "Input received"

#main comparisons
		if [ $mynum == $randnum ]; then
			echo "High five" > /home/assignment2/mynum.txt
			echo "Response: success"
			break
		elif (( $mynum < $randnum )); then
			echo "Too low" > /home/assignment2/mynum.txt
			echo "Response: too low"
		elif (( $mynum > $randnum )); then
			echo "Too high" > /home/assignment2/mynum.txt
			echo "Response: too high"
		else
			sleep 0
		fi

#send response
ftp -in $HOST <<EOF
user $USER $PASSWORD
put /home/assignment2/mynum.txt mynum.txt
exit
EOF
echo "Response sent"
rm /home/assignment2/mynum.txt

#if files dont exist
	else
		echo "Waiting for input..."
		sleep 1
	fi

done

#successful guess response
ftp -in $HOST <<EOF
user $USER $PASSWORD
put /home/assignment2/mynum.txt mynum.txt
exit
EOF
echo "High five sent"
