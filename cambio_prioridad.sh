#!/bin/bash
mysql -vvv -u "root" -proot_Mel0d\!A movistar_gua < cambio_prioridad.sql
mv /home/fecast/TT_Guatemala/in/cambio_prioridad.csv /home/fecast/TT_Guatemala/done