route delete 0.0.0.0 mask 0.0.0.0
route add 0.0.0.0 mask 0.0.0.0 192.168.25.1
route add 0.0.0.0 mask 0.0.0.0 146.250.16.2 metric 15
route delete 147.117.0.0 mask 255.255.0.0
route delete 153.88.0.0 mask 255.255.0.0 
route add 147.117.0.0 mask 255.255.0.0 146.250.16.2
route add 153.88.0.0 mask 255.255.0.0 146.250.16.2
pause

