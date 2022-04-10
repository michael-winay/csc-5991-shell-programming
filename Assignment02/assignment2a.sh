#!/bin/bash

FILE=/tmp/check.txt
EXISTS=0
RUNTIME=7200
SECONDS=0

while (( SECONDS < RUNTIME )); do
if [ -f "$FILE" ]; then
	EXISTS=1
	break
else
	sleep 2
fi
done


if [ $EXISTS -eq 0 ]; then
	echo 'Error: File could not be found' > ~/error.txt
else
	touch "/tmp/done.txt"
fi

STOPPED=$(date +"Stopped Execution at %c")
echo $STOPPED
