#!/bin/bash
FECHA=$(date '+%d_%m_%y')
archivo=$FECHA\_bak.gz
echo $FECHA
echo $archivo
/home/develop/performance/backup_SBC/expect_backup_SBC.sh $FECHA
/home/develop/performance/backup_SBC/expect_ftp_SBC.sh $archivo
