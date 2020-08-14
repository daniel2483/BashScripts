#!/bin/bash
mysql -vvv -u "root" -pMel0d1a -h 192.168.25.29 movistar_gua<guatemala_revenue_share_DB_test.sql
mv /home/fecast/Preventivos/in/preventivos_guatemala_revenue_share* /home/fecast/Preventivos/done
