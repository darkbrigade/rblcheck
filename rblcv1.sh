#!/bin/bash

### IP List File Path

Filepath=/etc/Servers

### Map IPs From IP List File

mapfile -t IP < $Filepath

### Maximum IPs

maxip=$(wc -l < $Filepath)
### Counter to use in Loops

realcount=$(expr $maxip - 1 )
count=0

### Loops

### Until Last IP Do

while [ $count -le $realcount ]
	do

### Variable to Use for Each IP in the Loop

ip=$(echo "${IP[$count]}")

### Files to Use in the Loop

RBLReport=/tmp/rblreport-$ip
RBLCheck=/tmp/rblcheck-$ip

### Do a RBLCheck

	rblcheck $ip > $RBLCheck

### Admin Logs

echo $(date) RBLcheck on $ip -- Done >> /etc/RBLlogs

### Variables to Check the Result

sbl=$(cat /tmp/rblcheck-$ip | xargs | cut -d " " -f 2)
xbl=$(cat /tmp/rblcheck-$ip | xargs | cut -d " " -f 7)
pbl=$(cat /tmp/rblcheck-$ip | xargs | cut -d " " -f 12)
bl=$(cat /tmp/rblcheck-$ip | xargs | cut -d " " -f 17)
psbl=$(cat /tmp/rblcheck-$ip | xargs | cut -d " " -f 22)
dul=$(cat /tmp/rblcheck-$ip | xargs | cut -d " " -f 27)

### Check the Results

if [ $sbl="not" ]; then
        true
else
        cat $RBLCheck | xargs | cut -d " " -f 1,2,3,4,5 >> $RBLReport
fi

if [ $xbl="not" ]; then
        true
else
        cat $RBLCheck | xargs | cut -d " " -f 6,7,8,9,10 >> $RBLReport
fi

if [ $pbl="not" ]; then
        true
else
        cat $RBLCheck | xargs | cut -d " " -f 11,12,13,14,15 >> $RBLReport
fi

if [ $bl="not" ]; then
        true
else
        cat $RBLCheck | xargs | cut -d " " -f 16,17,18,19,20 >> $RBLReport
fi

if [ $psbl="not" ]; then
        true
else
        cat $RBLCheck | xargs | cut -d " " -f 21,22,23,24,25 >> $RBLReport
fi

if [ $dul="not" ]; then
        true
else
        cat $RBLCheck | xargs | cut -d " " -f 26,27,28,29,30 >> $RBLReport
fi

### Send Email if Hostname was on Blacklists

if [ -f $RBLReport ]; then
        mail -s "RBL Check Report on $ip" iarchbrigade@gmail.com < $RBLReport
else
        true
fi

### Remove Temp Files

if [ -f $RBLReport ]; then
        rm -rf $RBLReport
else
        true
fi

if [ -f $RBLCheck ]; then
        rm -rf $RBLCheck
else
        true
fi

### Continue the loop

count=$(( $count + 1 ))

done


