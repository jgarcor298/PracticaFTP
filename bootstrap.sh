#!/bin/bash

# Antes que nada actualizamos la maquina virtual
sudo apt update
sudo apt upgrade -y

# Instalamos los paquetes necesarios para el servidor DNS
sudo apt install -y bind9 bind9utils bind9-doc

# Reemplazar fichero /etc/default/named
sudo cp /vagrant/config/named /etc/default/

# Hacer copia del fichero /etc/bind/named.conf.options
sudo cp /etc/bind/named.conf.options /etc/bind/named.conf.options_bck

# Reemplazar fichero /etc/bind/named.conf.options
sudo cp /vagrant/config/named.conf.options /etc/bind/named.conf.options

# Comprobamos que la configuración es correcta
named-checkconf /etc/bind/named.conf.options

# Reiniciamos el servicio named
sudo systemctl restart named

# Copiamos el fichero /etc/bind/named.conf.local
sudo cp /vagrant/config/named.conf.local /etc/bind/named.conf.local

# Copiamos el fichero /var/lib/bind/jorgegarre.test.dns
sudo cp /vagrant/config/jorgegarre.test.dns /var/lib/bind/

# Copiamos el fichero /var/lib/bind/jorgegarre.test.rev
sudo cp /vagrant/config/jorgegarre.test.rev /var/lib/bind/  

# Comprobamos que los ficheros esten configurados correctamente
# Estos comandos realmente no son necesarios en este fichero ya que no vamos a ver que devuelven
# Pero he considerado que esta bien dejarlos por aqui escritos por si acaso
named-checkzone jorgegarre.test. /var/lib/bind/jorgegarre.test.dns
named-checkzone 56.168.192.in-addr.arpa. /var/lib/bind/jorgegarre.test.rev

# Reiniciamos y comprobamos el servicio named
sudo systemctl restart named
sudo systemctl status named

# Comandos para la comprobación de la resolución del servidor
# Estos comandos realmente no son necesarios en este fichero ya que no vamos a ver que devuelven
# Pero he considerado que esta bien dejarlos por aqui escritos por si acaso
dig @192.168.56.10 jorgegarre.test
nslookup jorgegarre.test 192.168.56.10

# Copiar fichero resolv.conf
sudo cp /vagrant/config/resolv.conf /etc/

# Instalar paquete vsftpd
sudo apt install vsftpd -y

# Hacer copia de seguridad de fichero vsftpd.conf
sudo cp /etc/vsftpd.conf /etc/vsftpd.conf.bck

# Crear usuarios locales 
sudo useradd -m luis
echo "luis:luis" | sudo chpasswd

sudo useradd -m maria
echo "maria:maria" | sudo chpasswd

sudo useradd -m miguel
echo "miguel:miguel" | sudo chpasswd

# Crear ficheros de los usuarios y dar permisos
sudo touch /home/luis/luis{1,2}.txt
sudo chown -R luis:luis /home/luis
sudo touch /home/maria/maria{1,2}.txt
sudo chown -R maria:maria /home/maria

# Copiar ficheros de configuración del servidor ftp
sudo cp /vagrant/config/.message /srv/ftp/
sudo cp /vagrant/config/vsftpd.chroot_list /etc
sudo cp /vagrant/config/vsftpd.conf /etc

# Reinicar el servicio despues de añadir los ficheros
sudo systemctl restart vsftpd

# Añadir certificado ssl
sudo cp /vagrant/config/certs/jorgegarre.test.key /etc/ssl/private
sudo cp /vagrant/config/certs/jorgegarre.test.pem /etc/ssl/certs

sudo chmod 600 /etc/ssl/private/jorgegarre.test.key
sudo chmod 644 /etc/ssl/certs/jorgegarre.test.pem