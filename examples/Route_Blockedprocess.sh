#!/bin/bash
#Script para hacer insert a la base de datos estadistica
#######################################
#Created on Setember 19 2011          #
#By Sergio Murillo Salas +506 88973588#
#Services Engineer Ericsson ERC       #
#######################################

LANG=es_CR.UTF-8
export LANG

currentime=`date --date="now" +"%R"`;

echo "Develop123" | sudo -S rm /tmp/RouteFiles.txt > /dev/null 2>&1;
y=1;

indiceFile=`ls -ltrh /home/develop/Route_Blocked/input | grep "Route_Blocked-" | wc -l`;
ls -ltrh /home/develop/Route_Blocked/input | grep "Route_Blocked-" | sort | nawk '{print$8}' > /tmp/RouteFiles.txt;

while [[ $y -le $indiceFile ]]
do
  FileName=`cat /tmp/RouteFiles.txt | nawk -v val=$y 'NR==val' | nawk '{print$1}'`;    
  #echo $FileName;
  echo "DATE_ID,HOUR_ID,BC,Ruta,Trafico,Intentos Llamada,Llamadas Contestadas,No completadas,Dev Blk,Devs,%CMPL,%Congestión" > /home/develop/Route_Blocked/output/proc$FileName.csv;
  cat /home/develop/Route_Blocked/input/$FileName | nawk '/2013/' | nawk '{print$1","$2","$3","$4","$5","$6","$7","$8","$9","$10","$11","$12}' >> /home/develop/Route_Blocked/output/proc$FileName.csv;
  count=`cat /home/develop/Route_Blocked/input/$FileName | nawk '/2013/' | wc -l`;
  echo "Develop123" | sudo -S mv /home/develop/Route_Blocked/input/$FileName /home/develop/Route_Blocked/done/
  if [[ $count -eq 0 ]]
  then
     echo $currentime" Correo no enviado archivo proc$FileName.csv vacio" >> /home/develop/Route_Blocked/log/RouteBlocked.log;
     echo "Develop123" | sudo -S rm /home/develop/Route_Blocked/output/proc$FileName.csv;
  else
     /home/develop/performance/email_RouteBlocked.pl >> /home/develop/Route_Blocked/log/RouteBlocked.log;  
  fi
  y=$((y+1));
done
echo "Develop123" | sudo -S rm /tmp/RouteFiles.txt > /dev/null 2>&1;
