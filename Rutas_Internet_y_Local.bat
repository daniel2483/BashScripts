ipconfig
route delete 0.0.0.0
route add 0.0.0.0 mask 0.0.0.0 192.168.26.1
route add 192.168.25.0 mask 255.255.255.0 192.168.25.1
route add 192.168.26.0 mask 255.255.255.0 192.168.25.1
netstat -nr
ping 192.168.25.1
ping 192.168.25.30
ping 192.168.25.27
ping 192.168.25.28
ping 192.168.25.26

ping 192.168.26.1
ping 192.168.26.6

#ipconfig -release
#ipconfig -renew

ping www.google.com
ping youtube.com

pause
