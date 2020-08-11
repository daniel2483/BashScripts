#!/usr/bin/expect -f
#-----------------------------------------------------#
#    Ericsson script for healthcheck in CGSN          #
#       Created by: Victor Padilla evicpad            # 
#       Creation date: 22-05-2021                     #
#       Last update:   22-05-2012                      #
#-----------------------------------------------------# 

spawn ssh clasbcher01@10.196.36.116

expect "Enter passphrase for key '/home/develop/.ssh/id_rsa':"

send "Develop123\r"

expect "clasbcher01@10.196.36.116's password:"

send -- "3ricss0n@4CM3\r"

expect "Password:"

send "4cm3@S0p0rt3\r"

expect "CRHER1I-SBC01>"

send "enable\r"

expect "Password:"

send -- "P4ck3t@Cl4r0\r"

expect "CRHER1I-SBC01#"

send "display-backups \r"

expect "CRHER1I-SBC01#"

send "backup-config $argv\_bak.gz\r"

expect "CRHER1I-SBC01#"

send "display-backups \r"

expect "CRHER1I-SBC01#"

send "exit\r"

send -- "\r"
