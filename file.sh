
echo -e "[*] Buscant el hash i escrivint-lo al fitxer user_ftp.txt"
echo "$(sudo cat /etc/shadow | grep $USER)" > $PWD/FTP/user_ftp.txt
echo "*.txt" > $PWD/FTP/.dockerignore
