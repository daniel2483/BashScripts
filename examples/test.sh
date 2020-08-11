#!/bin/bash
x=1;
Fecha=`date '+%Y-%m-%d'`
cd /home/develop/performance/;
echo `ftp -n 10.196.19.68 <<END_SCRIPT
quote user nmsadm
quote pass nmsadm506
rm /home/nmsadm/performance/test1/*
rmdir /home/nmsadm/performance/test1
#get $Fie
#delete $File
quit
END_SCRIPT` >/dev/null 2>&1
