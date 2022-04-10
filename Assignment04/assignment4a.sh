#!/bin/bash

rm /home/assignment2/randnum.txt
rm /home/assignment2/mynum.txt

#user input for bounds
read -p "Enter lower bound: " lowerBound
read -p "Enter upper bound: " upperBound

#random number generation
echo $(( $RANDOM % $upperBound + $lowerBound )) > /home/assignment2/randnum.txt
touch /home/assignment2/mynum.txt

#Setting up FTP session
HOST="172.29.58.98"
USER="assignment2"
PASSWORD="badpassword123"
FILE="/home/assignment2/randnum.txt"
FILE2="/home/assignment2/mynum.txt"

#sending initial random number
ftp -in $HOST <<EOF
user $USER $PASSWORD
put $FILE randnum.txt
exit
EOF

#main loop
while :; do

#Check if number has been guessed
if [ -f $FILE2 ];then
	#Successful guess
	if grep -q "High five" $FILE2; then
		break
	#If number has not been guessed, make a new guess
	elif grep -q "Too low" $FILE2; then
		echo "Guess was too low"
		read -p "Enter number to guess: " input
		echo $input > $FILE2
	elif grep -q "Too high" $FILE2; then
		echo "Guess was too high"
		read -p "Enter number to guess: " input
		echo $input > $FILE2
	else
		read -p "Enter number to guess: " input
		echo $input > $FILE2
	fi

#Connecting to FTP
ftp -in $HOST <<EOF
user $USER $PASSWORD
put $FILE2 mynum.txt
exit
EOF

rm $FILE2

#Waiting on server response
else
	echo "Waiting for response..."
	sleep 1
fi

done

echo "High five received"
