#!/bin/bash
mysql -vvv -u "root" -pMel0d1a -h 192.168.25.29 movistar_gua<guatemala_infra_DB_test.sql
mv /home/fecast/Preventivos/in/preventivos_guatemala_infra* /home/fecast/Preventivos/done
