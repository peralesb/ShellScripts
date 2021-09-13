#!/bin/bash
#script file: watchdogMovistarPort.sh


PROCESS="nc 10.225.244.79 7881"
LOG_FILE=/var/log/watchdogMovistar.log


killall -9 nc	# Kill all nc process to sure restart the connection each period

#Check using the process list
PROCLST=$(ps aux| grep -v "grep" | grep "$PROCESS")
PROCCHK=$(ps aux| grep -v "grep" | grep -c "$PROCESS")
if [ $PROCCHK -eq 0 ]
then
        nohup $PROCESS &
	echo "$(date): Started movistar '$PROCESS'  Service" >> $LOG_FILE
        exit
else
        echo "$(date): $PROCESS is running $PROCLST processes" >> $LOG_FILE
fi

sleep 3

