#!/bin/bash

## Ian Baldwin <iantbaldwin@elektrikfish.com>
## IPSync V1.0 - 11/18/2014

# IPSync -  A program that checks to see if your public IP Adress has changed
# And notifies you if it has (via Pushover)!

## Constants
# Modify only if necessary
FILENAME=IP.sync # Name of the database file
DEVICENAME=ApachePi # Local Device Name (Should contain no whitespace)
DELIMITER=" | " # Delimiter used between the device name and the IP Adress
NOTIFY=true

##<------- DO NOT MODIFY  ------>##
# Checks IP Adress with outside resource, icanhazip.com
curIP=$(curl -s icanhazip.com)

# Checks to see if the IP database file exists (1 if true, 0 if false)
if [ ! -s $FILENAME ]; then
	touch $FILENAME
fi

# Count Number of devices in file
devCount=0
while read line; do
	((devCount++))
done < $FILENAME

# Create lists of devices and IP Address
curLine=0
while read line; do
	lineArray=($line)
	deviceList[$curLine]=${lineArray[0]}
	ipList[$curLine]=${lineArray[2]}}
	((curLine++))
done < $FILENAME

# Checks if device is one of the ones listed in the file
if [[ " ${lineArray[*]} " != *" $DEVICENAME "* ]]; then
	ipInfo=$DEVICENAME$DELIMITER$curIP
	echo $ipInfo >> $FILENAME
fi

## TO DO: If devices exists but IPs differ, replace IP and call notification script (if needed)
