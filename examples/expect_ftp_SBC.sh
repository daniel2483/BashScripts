#!/usr/bin/expect -f
#-----------------------------------------------------#
#    Ericsson script for healthcheck in CGSN          #
#       Created by: Victor Padilla evicpad            # 
#       Creation date: 22-05-2021                     #
#       Last update:   22-05-2012                      #
#-----------------------------------------------------# 

spawn sftp clasbcher01@10.196.36.116

expect "Enter passphrase for key '/home/develop/.ssh/id_rsa':"

send "Develop123\r"

expect "clasbcher01@10.196.36.116's password:"

send -- "3ricss0n@4CM3\r"

expect "sftp\>"        

send "cd /code/bkups\r"

expect "sftp\>"

send "lcd /home/develop/backups/sbc\r"

expect "sftp\>"

send "get $argv\r"

expect "sftp\>"

send "quit\r"

send -- "\r"
