#!/bin/bash

# Condicional que fa que si hi ha la network web existent, la elimini
if [ $(docker network ls | grep web) ]; then
	echo -e "[*] ELIMINANT LA XARXA WEB EXISTENT"
	docker network rm web
fi

#Busquem el hash del nostre usuari i el guardem en un fitxrer anomenat user_ftp.txt

echo -e "[*] Buscant el hash i escrivint-lo al fitxer user_ftp.txt"
echo -e "$(sudo cat /etc/shadow | grep $USER)" > $PWD/FTP/user_ftp.txt
echo -e "*.txt" > $PWD/FTP/.dockerignore
hash_user=$(cat $PWD/FTP/user_ftp.txt)
cat << FINAL > /tmp/cmd
FINAL
# Create network 
echo -e "[*]  Creant network web"
docker network create web

# Exportar credencials de traefik que hi ha al docker-compose
echo -e "[*] Exportant credencials.. \n\tusuari: profe \n\tpasswd: chequejant"
export ADMIN_USER=profe
export ADMIN_PASSWORD=chequejant
export HASHED_PASSWORD=check
#export HASHED_PASSWORD=$(openssl passwd -apr1 \$ADMIN_PASSWORD)

echo -e "[*] Assignant els permissos..."
sudo chown -R \$USER:\$USER *

# Creant la infraestuctura
echo -e "[*]  Creant la infraestuctura..."
docker-compose build
# Aixecant la infraestuctura
echo -e "[*]  Aixecant la infraestuctura..."
docker-compose up -d 
