 PAQUETES NECESARIOS
sudo apt-get install -y apache2

# ESTABLECIENDO VARIABLES
rutapache=/var/www
read -p "Introduce el nombre del host: " nombrehost
read -p "Introduce el puerto para conectar al host: " puertohost
read -p "Introduce email del admin: " sadmin

# CREANDO ESTRUCTURA DE DIRECTORIOS
sudo mkdir -p $rutapache/$nombrehost/public
sudo chown -R $USER:$USER $rutapache/$nombrehost/public
sudo chmod -R 755 /var/www

# CREANDO PAGINA DE EJEMPLO
sudo touch $rutapache/$nombrehost/public/index.html
sudo printf "\n\n<html><head><title>¡Bienvenido a $nombrehost! </title></head><body><h1>Lo lograste! El virtual host $nombrehost est&aacute; funcionando</h1></body></html>\n\n" | sudo tee $rutapache/$nombrehost/public/index.html
sudo chmod -R 755 /var/www

# CREANDO VIRTUAL HOST
sudo a2dissite 000-default.conf
sudo printf "<VirtualHost *:$puertohost>\n    ServerAdmin $sadmin\n    ServerName $nombrehost\n    ServerAlias $nombrehost\n    DocumentRoot $rutapache/$nombrehost/public\n" | sudo tee -a /etc/apache2/sites-available/000-default.conf
sudo printf "ErrorLog ${APACHE_LOG_DIR}/error.log\n    CustomLog ${APACHE_LOG_DIR}/access.log combined\n</VirtualHost>\n\n\n" | sudo tee -a /etc/apache2/sites-available/000-default.conf
sudo printf "Listen $puertohost\n" | sudo tee -a /etc/apache2/ports.conf
sudo a2ensite 000-default.conf

# REINICIANDO APACHE
sudo service apache2 restart
