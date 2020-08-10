#!/bin/bash

############################################################################
#   Creador: Jose Daniel Rodriguez Sanchez                                 #
#   Fecha:   07-09-2011                                                    #
#   Ultima Actualizacion: 08-09-2011                                       #
#   Script Utilizado para la concatenacion de archivos que contengan CDR's #
#   de Teletica                                                            #
############################################################################

# Declaracion de Variables
count=0
limit=$(ls /var/opt/BGw/Server2/TELETICA/tmpScriptConcatenate/TT.*.*R132 | wc -l)  # Obtengo cantidad de CDR's Teletica
limit2=$(ls /var/opt/BGw/Server2/TELETICA/tmpScriptConcatenate/TT.LDUN.*.??????2 | wc -l)  # Obtengo cantidad de CDR's LDUN Teletica
#limit=5
fecha=$(date)


#***********************************************#
# Muevo archivos TT.LDUN Teletica a carpeta FTP #
#***********************************************#
echo ""
echo "Fecha y Hora de inicio de script: " $fecha
echo ""
echo "Moviendo Archivos LDUN Teletica a salida:"
echo ""
if(($limit2>0))
then
for ((count=1; count<=$limit2; count++)) # Lazo de lectura de Archivos LDUN
do
        orig_file[count]=$(ls -rh /var/opt/BGw/Server2/TELETICA/tmpScriptConcatenate/TT.LDUN.*.??????2 | tail -1) # Obtengo path relativo y nombre de archivos Teletica y alamaceno en arreglo
        mv ${orig_file[count]} /var/opt/BGw/Server2/TELETICA/script_concatenate/salida/                              # Muevo Archivos LDUN a carpeta salida 
	orig_file[count]=`echo ${orig_file[$count]} | cut -d/ -f8`
	echo ${orig_file[$count]}
done
count=0
fi

if(($limit>0))
then

#***********************************#
# Muevo archivos a carpeta temporal #
#***********************************#

count=0
echo ""
echo "Moviendo Archivos Teletica a temporal:"
echo ""

for ((count=1; count<=$limit; count++)) # Lazo de lectura de Archivos
do
	orig_file[count]=$(ls -rh /var/opt/BGw/Server2/TELETICA/tmpScriptConcatenate/TT.*.*R132 | tail -1) # Obtengo path relativo y nombre de Teletica y alamaceno en arreglo 
        mv ${orig_file[count]} /var/opt/BGw/Server2/TELETICA/script_concatenate/tmp                                  # Muevo Archivos a carpeta temporal
	orig_file[count]=`echo ${orig_file[$count]} | cut -d/ -f8`    # Dejo solamente el nombre del archivo 
	echo ${orig_file[$count]}	
done

for ((count=1; count<=$limit; count++)) # Lazo para impresion de Archivos concatenados
do
	echo ${orig_file[count]}
done

#************************************************************#
# Concateno Archivos y almaceno en archivo con ultimo nombre #
#************************************************************#

count=$(($count-1))
echo ""
echo "Cantidad de archivos a concatenar: " $count
echo ""
echo "Concatenando CDR's Teletica:"
echo ""
name=${orig_file[$count]} # Nombro el Archivo con el ultimo archivo procesado
echo "" 
echo "Nombre del Archivo Concatenado:" $name
echo ""
touch ./salida/$name #Creo el nombre del archivo donde se concatenaran
chown bgw:med /var/opt/BGw/Server2/TELETICA/script_concatenate/salida/* # Modifico propietario

for ((count=1; count<=$limit; count++))    # Lazo de concatenacion de Archivos
do
	echo "Concatenando Archivo " $count
	cat /var/opt/BGw/Server2/TELETICA/script_concatenate/tmp/${orig_file[$count]} >> /var/opt/BGw/Server2/TELETICA/script_concatenate/salida/$name   # Concateno archivos y lo almaceno en directorio salida
done
count=$(($count-1))
echo ""
echo "Cantidad de Archivos concatenados:" $count 
echo ""
echo "Archivo Concatenado: " /var/opt/BGw/Server2/TELETICA/script_concatenate/salida/$name 
echo ""
cat /var/opt/BGw/Server2/TELETICA/script_concatenate/salida/$name
mv /var/opt/BGw/Server2/TELETICA/script_concatenate/tmp/TT.*.*R132  /var/opt/BGw/Server2/TELETICA/script_concatenate/tmp2/ 
echo "Enviando Archivo concatenado a tmptoSolt: " $name
mv /var/opt/BGw/Server2/TELETICA/script_concatenate/salida/$name /var/opt/BGw/Server2/TELETICA/tmptoSolt/

fi


fecha=$(date)
echo "" 
echo "Fecha y Hora de fin de script: " $fecha