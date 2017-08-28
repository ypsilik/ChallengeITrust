#!/bin/bash

FILE=Sources/ips.csv
cat $FILE | tr -d '"' > NEWFILE
cat NEWFILE

IFS=","
while read ips os 
do
	oslite=`echo $os | cut -d ' ' -f 1`
	echo $os
	case $oslite in
		Debian | Ubuntu ) 
			echo deb
			;;
		Fedora | CentOS ) 
			echo fed 
			;;
		Alpine )
			echo apl
			;;
		* )
			echo "No Linux System"
			;;
	esac
done < NEWFILE
