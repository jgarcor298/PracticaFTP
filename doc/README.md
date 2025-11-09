# Documentación Práctica FTP - Jorge Garre

**Autor:** Jorge Garre Corrales

---

## Índice

- [1. Uso del cliente FTP gráfico](#1-uso-del-cliente-ftp-gráfico)
- [2. Instalación y configuración del servidor vsftpd sobre Linux](#2-instalación-y-configuración-del-servidor-vsftpd-sobre-linux)
- [3. Configuración del servidor vsftpd seguro (FTPS)](#3-configuración-del-servidor-vsftpd-seguro-ftps)

---

## 1. Uso del cliente FTP gráfico

El cliente FTP que he elegido para realizar la práctica es **CyberDuck**.

![](assets/20251108_123846_image.png)

### Pasos realizados

1. Crear el directorio `pruebasFTP` en el anfitrión y acceder a él.
2. Crear en el directorio `pruebasFTP` el archivo `datos1.txt` con el contenido deseado.

   ![](assets/20251108_124023_image.png)
3. Establecer una conexión **anónima** al servidor `ftp.cica.es`.

   ![](assets/20251108_124141_image.png)
4. Desde el cliente, descargar el archivo `/pub/check`.

   ![](assets/20251108_124220_image.png)
5. Comprobar que se ha descargado el archivo correctamente.

   ![](assets/20251108_124405_image.png)
6. Intentar subir al servidor el archivo `datos1.txt`.

   ![](assets/20251108_124613_image.png)
7. Cerrar la conexión con el servidor.

   ![](assets/20251108_124829_image.png)

---

## 2. Instalación y configuración del servidor vsftpd sobre Linux

Instalar el servidor **vsftpd** en `ftp.example.com` y añadir un registro **CNAME** en la zona DNS que apunte desde `ftp.example.com` al servidor donde se alojará el servicio.

![](assets/20251108_130825_image.png)

### 2.1 Instalación del paquete

1. Instalar el paquete `vsftpd`:

   ![](assets/20251108_131804_image.png)
2. Comprobar que se ha creado el usuario `ftp` y que su directorio home es `/srv/ftp`.
   Consultar los archivos del sistema `/etc/passwd` y `/etc/group`.

   ![](assets/20251108_131921_image.png)
3. Verificar que el directorio `/srv/ftp` pertenece al usuario `root` y al grupo `ftp`.

   ![](assets/20251108_132112_image.png)
4. Listar los usuarios del sistema que no podrán acceder al servicio FTP (según el fichero `ftp-linux.pdf` en la sección *Archivos de configuración*).

   ![](assets/20251108_132321_image.png)

### 2.2 Verificación del servicio

5. Comprobar que el servidor está **iniciado y en ejecución** usando `systemctl`.

   ![](assets/20251108_132629_image.png)
6. Verificar que el servidor escucha por el **puerto 21/TCP** con `ss -tlpn`.

   ![](assets/20251108_132941_image.png)
7. Realizar una **copia de seguridad** del archivo de configuración `/etc/vsftpd.conf`.

   ![](assets/20251108_133057_image.png)

### 2.3 Configuración de usuarios

8. Crear los usuarios locales `luis`, `maria` y `miguel`.

   ![](assets/20251108_133633_image.png)
9. Crear los archivos de prueba necesarios.

   ![](assets/20251108_134418_image.png)

### 2.4 Configuración del servicio FTP

10. Modificar el archivo de configuración del servicio FTP.
    Para la configuración, copié el archivo en la carpeta `vagrant` del proyecto para editarlo desde VS Code y, después, lo copié a la máquina.

    ![](assets/20251108_153629_image.png)
11. Crear los archivos adicionales:

    - `.message`: mensaje de bienvenida para usuarios anónimos.
    - `vsftpd.chroot_list`: usuarios que **no** estarán enjaulados (solo `maria`).

### 2.5 Pruebas de conexión

12. Reiniciar el servicio y comprobar su estado, asegurando que escucha en el **puerto 21/TCP**.

    ![](assets/20251108_160922_image.png)
13. Realizar una **conexión anónima** desde el cliente FTP y comprobar la secuencia de conexión.

    ![](assets/20251108_162106_image.png)
14. Realizar una **conexión autenticada con el usuario `maria`** y comprobar que **NO está enjaulada** en su directorio home.

    ![](assets/20251108_162256_image.png)
15. Realizar una **conexión autenticada con el usuario `luis`** y comprobar que **SÍ está enjaulado** en su home.

    ![](assets/20251108_162420_image.png)

---

## 3. Configuración del servidor vsftpd seguro (FTPS)

### 3.1 Generación del certificado SSL

1. Generar el certificado y la clave privada.

   ![](assets/20251109_120100_image.png)

   Una vez generados, se copiaron ambos ficheros a la carpeta `/vagrant/config/certs` para incluirlos desde el fichero provisional y darles permisos correctos, de forma que el certificado esté activo en cada arranque de la máquina.

### 3.2 Configuración del archivo `vsftpd.conf`

2. Añadir las directivas necesarias para habilitar el uso del certificado SSL:

   ![](assets/20251109_121124_image.png)

### 3.3 Reinicio y comprobación del servicio

3. Reiniciar el servicio y comprobar que se ejecuta correctamente en el **puerto 21**.

   ![](assets/20251109_121501_image.png)

### 3.4 Pruebas de conexión segura

4. Probar la conexión segura desde un cliente gráfico (**CyberDuck**) con el usuario `luis`.

   ![](assets/20251109_123810_image.png)
5. Aceptar el certificado del servidor y descargar un archivo, comprobando el **candado cerrado** en la interfaz del cliente (conexión cifrada).

   ![](assets/20251109_123950_image.png)
   ![](assets/20251109_124013_image.png)
6. Realizar una **conexión segura anónima**.

   ![](assets/20251109_124137_image.png)
7. Realizar una **conexión segura autenticada** con otro usuario.

   ![](assets/20251109_124227_image.png)
