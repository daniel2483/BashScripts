::// Se borra ruta default
route delete 0.0.0.0
route add 0.0.0.0 mask 0.0.0.0 146.250.52.1
route add 146.250.0.0 mask 255.255.0.0 146.250.52.1

::// Servidores
route add 192.168.25.0 mask 255.255.255.0 192.168.2.1

::// Virtual Machine
route add 192.168.26.0 mask 255.255.255.0 192.168.2.1

::// Firewall
route add 192.168.7.0 mask 255.255.255.0 192.168.2.1

pause