#!/bin/bash

## Ian Baldwin <iantbaldwin@elektrikfish.com>
## IPSync V1.0 - 11/18/2014

# IPSync -  A program that checks to see if your public IP Adress has changed
# And notifies you if it has (via Pushover)!

## Constants
DATABASE=IPSync.db
NAMEFILE=device.name
if [ ! -s $NAMEFILE ]; then
	echo "Namefile required. Enter device name (one word, no spaces): "
	read devName
	echo $devName > $NAMEFILE
fi
DEVICENAME=$(cut -d' ' -f1 $NAMEFILE)
DELIMITER=":"

# Checks IP Adress with external resource, icanhazip.com
curIP=$(wget -O - -q icanhazip.com)

# Checks to see if the IP database file exists
# Creates it if it does not
if [ ! -s $DATABASE ]; then
	touch $DATABASE
fi

# Count Number of devices in file
devCount=0
while read line; do
	((devCount++))
done < $DATABASE

# Create array lists of device names and IP addresses
curLine=0
while read line; do
	lineArray=($line)
	deviceList[$curLine]=${lineArray[0]}
	ipList[$curLine]=${lineArray[2]}
	((curLine++))
done < $DATABASE
unset curLine

# Checks if device is one of the ones listed in the file and
# records the device number if it does, else it creates
# the listing in the database file
deviceNumber=-1
i=0
if [[ " ${lineArray[*]} " != *" $DEVICENAME "* ]]; then
	deviceList[$((devCount))]=$DEVICENAME
	ipList[$((devCount))]=$curIP
	((devCount++))
else
	while [ $i -lt $devCount ]; do
		if [[ "${deviceList[$i]}" == "$DEVICENAME" ]]; then
			deviceNumber=$i
		fi
		((i++))
	done
fi
unset i

# Change the corresponding IP Address if different
if [ ${ipList[$deviceNumber]} != $curIP ]; then
	echo "IP Address changed from ${ipList[$deviceNumber]} to $curIP"
	ipList[$deviceNumber]=$curIP
fi

# Build the formated array
i=0
while [ $i -lt $devCount ]; do
	outputArray[$i]="${deviceList[$i]} $DELIMITER ${ipList[$i]}"
	((i++))
done

# Output changes to file
printf "%s\n" "${outputArray[@]}" > $DATABASE
