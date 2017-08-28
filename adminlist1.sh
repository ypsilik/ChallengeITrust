#!/bin/bash

## Création d'un fichier sans les guillemets
FILE=Sources/ips.csv
cat $FILE | tr -d '"' > NEWFILE
cat NEWFILE

## Récupération du patch
cdpatch="cd /usr/lib/python2.7"
patch="wget me.git/patch/ssl.patch" 

IFS=","

## Lecture de chaque ligne avec définition de l'os et des actions
while read ip os 
do
	oslite=`echo $os | cut -d ' ' -f 1`
	echo $os
	case $oslite in
		Debian | Ubuntu ) 
			ssh@$ip "apt-get install -y python-openssl ; dpkg -s python-openssl | grep Status ; $cdpatch ; $patch ; patch ssl.patch 2>&1 | tee /var/log/patch.log "
			;;
		Fedora )
			ssh@$ip "dnf install python-openssl ; dnf info python-openssl | grep status ; $cdpatch ; $patch ; patch ssl.patch 2>&1 | tee /var/log/patch.log "
			;;
		CentOS ) 
			ssh@$ip "yum install python-openssl ; yum info python-openssl | grep status ; $cdpatch ; $patch ; patch ssl.patch 2>&1 | tee /var/log/patch.log "
			;;
		Alpine )
			ssh@$ip "apk add python-openssl ; apk info python-openssl | grep status ; $cdpatch ; $patch ; patch ssl.patch 2>&1 | tee /var/log/patch.log "
			;;
		* )
			echo "No Linux System"
			;;
	esac
done < NEWFILE


## Suppression du fichier temp
rm NEWFILE


# ssh@ip "$paquetInstall python-openssl ; $paquetInfo python-openssl | grep status ; $cdPython ; $patch ; patch ssl.patch 2>&1 | tee /var/log/patch.log"
