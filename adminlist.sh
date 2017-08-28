#!/bin/bash

## suppression windows / mac / titre
cat Sources/ips.csv | egrep -v 'Windows|IPs|OS' > noWindows.txt

## connexion ssh
for i in $(cat noWindows.txt | cut -d, -f1 | cut -d '"' -f 2); do 
	echo ssh admin@$i
done


## suppression fichier temp
rm noWindows.txt

