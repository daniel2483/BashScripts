#!/bin/bash

############################################################################################
#       Descripcion: Script utilizado para estadisticas STP formateador de crudos          #    
#       Creador: Daniel Rodriguez Sanchez                                                  #
#       Fecha: 23-01-2012                                                                  #
#       Ultima Fecha de Actualizacion: 06-03-2012                                          #
############################################################################################

dir="/home/develop/stp-output/statistics_TPS"

limit=$(ls $dir/STP_* | wc -l)
limit2=12
count=0

echo ""
echo "List of files to delete:"
files=$(find /home/develop/stp-output/statistics_TPS/ -name "STP_*" -size -3k)
echo $files
echo "Deleting invalid files..."
find /home/develop/stp-output/statistics_TPS/ -name "STP_*" -size -3k -exec rm {} \;

echo ""
echo "Number of files to process" $limit 
echo ""
echo "Reading files:"

for ((count=1; count<=$limit; count++)) 
do
archive=$(ls $dir/STP_* | tail -1)
archive=`echo ${archive} | cut -d/ -f6`

echo $archive

tr -d '\001' < $dir/$archive > $dir/temporal.txt

#gzip $dir/$archive
mv $dir/$archive $dir/logs_read/

fecha=$(cat $dir/temporal.txt | nawk 'NR==17' | nawk '{print(substr($3,1,8))}')
hora=$(cat $dir/temporal.txt | nawk 'NR==17' | nawk '{print(substr($4,1,5))}')
n_fila=40
loop_print=12
adjust=3

for ((count2=1; count2<=$loop_print; count2++))
do

if(($count2==1))
then
echo "Making new file..."

	length_nodo=$(cat $dir/temporal.txt | nawk "NR==$n_fila" | nawk '{print($1)}' | wc -m)
	#echo $length_nodo
	length_nodo=$(expr $length_nodo - $adjust)
	#echo $length_nodo
	nodo=$(cat $dir/temporal.txt | nawk "NR==$n_fila" | nawk -v x=$length_nodo '{print(substr($1,1,x))}')
	valortx=$(cat $dir/temporal.txt | nawk "NR==$n_fila" | nawk '{print(substr($6,1,5))}')
	picotx=$(cat $dir/temporal.txt | nawk "NR==$n_fila" | nawk '{print(substr($7,1,5))}')
	n_fila=$n_fila+1
	#echo $n_fila
	valorrx=$(cat $dir/temporal.txt | nawk "NR==$n_fila" | nawk '{print(substr($2,1,5))}')
	picorx=$(cat $dir/temporal.txt | nawk "NR==$n_fila" | nawk '{print(substr($3,1,5))}')
	n_fila=$n_fila+1
	#echo $n_fila

	echo ""
	echo "raw" $count2
	echo "20$fecha $hora $nodo $valortx $valorrx $picotx $picorx" > $dir/processed_$archive

else
	length_nodo=$(cat $dir/temporal.txt | nawk "NR==$n_fila" | nawk '{print($1)}' | wc -m)
	#echo $length_nodo
	length_nodo=$(expr $length_nodo - $adjust)
	#echo $length_nodo
	nodo=$(cat $dir/temporal.txt | nawk "NR==$n_fila" | nawk -v x=$length_nodo '{print(substr($1,1,x))}')
	valortx=$(cat $dir/temporal.txt | nawk "NR==$n_fila" | nawk '{print(substr($6,1,5))}')
	picotx=$(cat $dir/temporal.txt | nawk "NR==$n_fila" | nawk '{print(substr($7,1,5))}')
	n_fila=$n_fila+1
	#echo $n_fila
	valorrx=$(cat $dir/temporal.txt | nawk "NR==$n_fila" | nawk '{print(substr($2,1,5))}')
	picorx=$(cat $dir/temporal.txt | nawk "NR==$n_fila" | nawk '{print(substr($3,1,5))}')
	n_fila=$n_fila+1
	#echo $n_fila

	echo "raw" $count2
	echo "20$fecha $hora $nodo $valortx $valorrx $picotx $picorx" >> $dir/processed_$archive
fi
done
done

echo ""
echo "All files has been processed..."
echo ""
