#!/bin/bash
#Script para hacer insert a la base de datos estadistica
#######################################
#Created on Setember 19 2011          #
#By Sergio Murillo Salas +506 88973588#
#Services Engineer Ericsson ERC       #
#######################################

LANG=es_CR.UTF-8
export LANG

echo "Develop123" | sudo -S rm /home/develop/Files3GDown.txt > /dev/null 2>&1;
y=1;
indiceFile=`ls -ltrh /home/develop/cleanup | grep "3GDowntime" | wc -l`;
ls -ltrh /home/develop/cleanup | grep "3GDowntime" | sort | nawk '{print$8}' > /home/develop/Files3GDown.txt;

while [[ $y -le $indiceFile ]]
do
 #indice de la cantidad de lineas a procesar
 echo "Develop123" | sudo -S rm /tmp/indiceDB3G.txt > /dev/null 2>&1;
 echo "Develop123" | sudo -S rm /tmp/sitio3GDown.txt > /dev/null 2>&1;
 
 FileName=`cat /home/develop/Files3GDown.txt | nawk -v val=$y 'NR==val' | nawk '{print$1}'`;
 printf "%s\n" > /tmp/3GDowntmp.txt;
 cat /home/develop/cleanup/$FileName >> /tmp/3GDowntmp.txt;
 indice=`cat /tmp/3GDowntmp.txt | sort | uniq | wc -l`;

 x=1; 
 
 mysql -u root -pMroiner estadisticas -e "SELECT MAX(ID_Nodo_Historico) from estadisticas.DataNodo_Historico INTO OUTFILE '/tmp/indiceDB3G.txt';";
 val1=`cat /tmp/indiceDB3G.txt`;
 #Loop para analizar cada linea del archivo
 while [[ $x -le $indice ]]
 do
  #echo $x;  
  if [[ $val1 -gt 0 ]]
  then
      val1=$((val1+1));
  else
     val1=1;
  fi
  linea=`head -$x /tmp/3GDowntmp.txt | nawk -v val=$x 'NR==val'`;
  sitio=`echo $linea | nawk '{print$1}'`;
  mysql -u root -pMroiner estadisticas -e "SELECT ID_Nodo from estadisticas.Nodo where nombre_nodo='$sitio' INTO OUTFILE '/tmp/sitio3GDown.txt';";
  val2=`cat /tmp/sitio3GDown.txt`;
  i=9;
  for i in {9..11..1}
  do   
    val3=$i
    if [[ $i -eq 9 ]]
    then
     val4=`echo $linea | nawk '{print$2}'`;
     val5=`cat /home/develop/Files3GDown.txt | nawk -v val=$y 'NR==val' | nawk '{print(substr($1,16,4)"-"substr($1,12,2)"-"substr($1,14,2))}'`;     
     val6=`cat /home/develop/Files3GDown.txt | nawk -v val=$y 'NR==val' | nawk '{print(substr($1,21,2)":00")}'`;     
     val7=2;
  
     Length=`echo $val2 | nawk '{print length}'`;
     if [[ $Length -gt 0 ]]
     then
      #mysql -u root -pMroiner estadisticas -e "INSERT INTO estadisticas.DataNodo_Historico(ID_Nodo_Historico,ID_nodo,ID_dato,Dato,Fecha,Hora,ID_tech) VALUES($val1,$val2,$val3,$val4,'$val5','$val6',$val7);";
      echo $val1 $val2 $val3 $val4 $val5 $val6 $val7;
      echo "Insert OK";
     else
      echo "Insert no exitoso";
      val1=$((val1-1));
     fi
    else
      if [[ $i -eq 10 ]]
       then
        val1=$((val1+1));
        val3=$i        
        val4=`echo $linea | nawk '{print$3}'`;
        val5=`cat /home/develop/Files3GDown.txt | nawk -v val=$y 'NR==val' | nawk '{print(substr($1,16,4)"-"substr($1,12,2)"-"substr($1,14,2))}'`;        
        val6=`cat /home/develop/Files3GDown.txt | nawk -v val=$y 'NR==val' | nawk '{print(substr($1,21,2)":00")}'`;        
        val7=2;
                 
        Length=`echo $val2 | nawk '{print length}'`;
        if [[ $Length -gt 0 ]]
        then
         #mysql -u root -pMroiner estadisticas -e "INSERT INTO estadisticas.DataNodo_Historico(ID_Nodo_Historico,ID_nodo,ID_dato,Dato,Fecha,Hora,ID_tech) VALUES($val1,$val2,$val3,$val4,'$val5','$val6',$val7);";
         echo $val1 $val2 $val3 $val4 $val5 $val6 $val7;
         echo "Insert OK";
        else
         echo "Insert no exitoso";
         val1=$((val1-1));                             
        fi
      else 
       if [[ $i -eq 11 ]]
       then                 
        val1=$((val1+1)); 
        val3=$i       
        val4=`echo $linea | nawk '{print$4}'`;
        val5=`cat /home/develop/Files3GDown.txt | nawk -v val=$y 'NR==val' | nawk '{print(substr($1,16,4)"-"substr($1,12,2)"-"substr($1,14,2))}'`;        
        val6=`cat /home/develop/Files3GDown.txt | nawk -v val=$y 'NR==val' | nawk '{print(substr($1,21,2)":00")}'`;        
        val7=2;
                                          
        Length=`echo $val2 | nawk '{print length}'`;
        if [[ $Length -gt 0 ]]
        then
         #mysql -u root -pMroiner estadisticas -e "INSERT INTO estadisticas.DataNodo_Historico(ID_Nodo_Historico,ID_nodo,ID_dato,Dato,Fecha,Hora,ID_tech) VALUES($val1,$val2,$val3,$val4,'$val5','$val6',$val7);";
         echo $val1 $val2 $val3 $val4 $val5 $val6 $val7;
         echo "Insert OK";
         else
          echo "Insert no exitoso";
          val1=$((val1-1));
         fi
        fi           
      fi      
    fi
  done
  #sudo rm /tmp/indiceDB3G.txt;
  echo "Develop123" | sudo -S rm /tmp/sitio3GDown.txt > /dev/null 2>&1;
  #val1=$((val1+1));
  x=$((x+1));
 done
 y=$((y+1));
done
echo "Develop123" | sudo -S rm /home/develop/cleanup/3GDowntime*  > /dev/null 2>&1;
