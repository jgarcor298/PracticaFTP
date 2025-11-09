## Documentación Práctica FTP - Jorge Garre

**Autor:** Jorge Garre Corrales

### 2. Uso del cliente FTP gráfico.

El cliente FTP que yo he elegido para realizar la práctica es CyberDuck

![](assets/20251108_123846_image.png)

3. Crea el directorio pruebasFTP en el anfitrión y cámbiate a dicho directorio.
4. Crea en el directorio pruebasFTP el archivo datos1.txt con el contenido que quieras.

![](assets/20251108_124023_image.png)

5. Establece una conexión anónima al servidor ftp.cica.es.

![](assets/20251108_124141_image.png)

6. Desde el cliente descarga el archivo /pub/check

![](assets/20251108_124220_image.png)

7. Comprueba que se ha descargado el archivo

![](assets/20251108_124405_image.png)

8. Desde el cliente intenta subir al servidor el archivo datos1.txt.

![](assets/20251108_124613_image.png)

9. Cierra la conexión con el servidor.

![](assets/20251108_124829_image.png)

### 3. Instalación y configuración del servidor vsftpd sobre Linux

Instala el servidor vsfptd en ftp.example.com y añade un registro CNAME en la zona DNS que
apunte de ftp.example.com al servidor donde se alojará.

![](assets/20251108_130825_image.png)

1. Instala el paquete vsftpd

![](assets/20251108_131804_image.png)

2. Comprueba que se ha creado el usuario ftp y que su directorio home es /srv/ftp. Busca estos
   datos en los archivos del sistema donde se guardan los usuarios (/etc/passwd), y donde se
   guardan los grupos de usuarios (/etc/group).

![](assets/20251108_131921_image.png)

3. Comprueba que se ha creado el directorio /srv/ftp y que su propietario es el usuario root, y que su grupo es ftp.

![](assets/20251108_132112_image.png)

4. Lista los usuarios del sistema que no podrán acceder al servicio FTP (mira el fichero ftplinux.pdf en la sección Archivos de configuración).

![](assets/20251108_132321_image.png)

5. Comprueba que el servidor está iniciado y en ejecución (Usa systemctl).

![](assets/20251108_132629_image.png)

6. Comprueba que el servidor está escuchando por el puerto 21 (usa ss -tlpn).

   ![](assets/20251108_132941_image.png)
7. Realiza una copia de seguridad del archivo de configuración /etc/vsftpd.conf.

![](assets/20251108_133057_image.png)

8. Crea los usuarios locales luis, maria y miguel

![](assets/20251108_133633_image.png)

9. Crearemos unos ficheros de prueba:

   ![](assets/20251108_134418_image.png)
10. Modifica el archivo de configuración del servicio FTP

    Para la cofiguración del fichero he copiado el fichero en mi la carpeta vagrant del proyecto para poder estarlo desde VSCode y despues en el fichero provisional copiarlo a la máquina.

    ![](assets/20251108_153629_image.png)

Una vez configurado el fichero he tenido que crear el archivo .message (Para el mensaje de bienvenida de usuarios anonimos) y el fichero vsftpd.chroot_list (Para indicar que el usuario maria no esta enjaulado)

j. Al reiniciar el servicio asegúrate de su estado y que el servidor está a la escucha por el
puerto 21/TCP.

![](assets/20251108_160922_image.png)

k. Desde el cliente FTP, realiza una conexión anónima y comprueba la secuencia de conexión.

![](assets/20251108_162106_image.png)

l. También realiza una conexión autentificada con el usuario maria y comprueba que NO está
enjaulado en su home.

![](assets/20251108_162256_image.png)

m. Además realiza una conexión autentificada con el usuario luis y comprueba que SI está
enjaulado en su home.

![](assets/20251108_162420_image.png)

### 4. Configuración del servidor vsftpd seguro Linux

1. Generar certificado![](assets/20251109_120100_image.png)
   Una vez generados ambos ficheros los he copiado en la carpeta /vagrant/config/certs para añadirlos desde el fichero provisional, darle permisos y que el certificado este activo siempre que se inicie la máquina
2. Configurar fichero vsftpd.conf
   Estas són las directivas que he añadido para el funcionamiento del certificado SSL![](assets/20251109_121124_image.png)
3. Reiniciar servicio y comprobar que se ejecuta en el puerto 21

![](assets/20251109_121501_image.png)

2. Para probar la conexión segura, usa un cliente gráfico. Crea una sesión segura autentificada con el usuario luis.

   ![](assets/20251109_123810_image.png)
3. Realiza la conexión y acepta el certificado del servidor. Una vez realizada la conexión, prueba a descargarte del servidor algún archivo. Asegúrate que la conexión es segura observando el candado cerrado que aparece en la parte inferior de la ventana de conexión.![](assets/20251109_123950_image.png)



![](assets/20251109_124013_image.png)



4. Realiza ahora una conexión segura anónima.

![](assets/20251109_124137_image.png)


5. Realiza una conexión segura con algún usuario.

   ![](assets/20251109_124227_image.png)
