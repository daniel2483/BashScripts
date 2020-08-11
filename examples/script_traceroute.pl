#!/usr/bin/expect -f
#-----------------------------------------------------#
#    Ericsson script for healthcheck in CGSN          #
#       Created by: Victor Padilla evicpad            # 
#       Creation date: 22-05-2021                     #
#       Last update:   22-05-2012                      #
#-----------------------------------------------------# 

spawn ssh jramos@10.196.36.228

expect "jramos@10.196.36.228's password: "

send -- "claro@2012\r"

expect "\[local\]SCDESCRMPN1C1EZA1#"

send "context gi\r"

expect "\[gi\]SCDESCRMPN1C1EZA1#"

send "traceroute 4.2.2.2\r"

send "exit\r"

send -- "\r"

expect eof
