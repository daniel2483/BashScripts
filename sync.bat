::// Se llega al path para correr script

cd "C:\wamp\www\sincronizacion"

::// AMX Nicaragua
php bin\console sincronizacion:sync --id=7 
timeout 5
::// Argentina
php bin\console sincronizacion:sync --id=8
timeout 5
::// Guatemala y Nicaragua
php bin\console sincronizacion:sync --id=9 
timeout 5
::// TELCEL LIGHT
php bin\console sincronizacion:sync --id=12
timeout 5
::// Salvador Falcom
php bin\console sincronizacion:sync --id=13
timeout 5
::// Puerto Rico AMX
php bin\console sincronizacion:sync --id=15
:://timeout 5

:://pause



:://proceso_id 63
