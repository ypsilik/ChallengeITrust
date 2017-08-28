#!/bin/bash

FILE=Sources/ips.csv
cat $FILE | tr -d '"' > NEWFILE
cat NEWFILE

IFS=","
while read ip os 
do
	oslite=`echo $os | cut -d ' ' -f 1`
	echo $os
	case $oslite in
		Debian | Ubuntu ) 
			echo ssh@$ip \'apt-get install -y python-openssl\'
			;;
		Fedora )
			echo ssh@$ip \'dnf install python-openssl\'
			;;
		CentOS ) 
			echo ssh@$ip \'yum install python-openssl\'
			;;
		Alpine )
			echo ssh@$ip \'apk install python-openssl\'
			;;
		* )
			echo "No Linux System"
			;;
	esac
done < NEWFILE
