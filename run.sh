#!/bin/bash

# Condicional que fa que si hi ha la network web existent, la elimini
if [ $(docker network ls | grep web) ]; then
	echo -e "[*] ELIMINANT LA XARXA WEB EXISTENT"
	docker network rm web
fi

# Create network 
echo -e "[*]  Creant network web"
docker network create web

# Exportar credencials de traefik que hi ha al docker-compose
echo -e "[*] Exportant credencials.. \n\tusuari: profe \n\tpasswd: chequejant"
export ADMIN_USER=profe
export ADMIN_PASSWORD=chequejant
export HASHED_PASSWORD="$$2y$$05$$mOTJ0eItIAdzsp7lUDnWaetnJlPNUp9VB55mYC3rw0goHmbQK67lS"
#export HASHED_PASSWORD=$(openssl passwd -apr1 \$ADMIN_PASSWORD)

echo -e "[*] Assignant els permissos..."
sudo chown -R \$USER:\$USER *

# Creant la infraestuctura
echo -e "[*]  Creant la infraestuctura..."
docker-compose build
# Aixecant la infraestuctura
echo -e "[*]  Aixecant la infraestuctura..."
docker-compose up -d
