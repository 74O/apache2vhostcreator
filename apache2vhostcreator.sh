

# PAQUETES NECESARIOS
sudo apt-get install -y apache2




# ESTABLECIENDO VARIABLES
rutapache=/var/www
read -p "Introduce el nombre del host: " nombrehost
read -p "Introduce email del admin: " sadmin


# CREANDO ESTRUCTURA DE DIRECTORIOS
sudo mkdir -p $rutapache/$nombrehost/public
sudo chown -R $USER:$USER $rutapache/$nombrehost/public
sudo chmod -R 755 /var/www

# CREANDO PAGINA DE EJEMPLO
sudo touch $rutapache/$nombrehost/public/index.html
sudo printf "\n\n<html><head><title>¡Bienvenido a $nombrehost! </title></head><body><h1>¡Lo lograste! El virtual host $nombrehost está funcionando</h1></body></html>\n\n" | sudo tee $rutapache/$nombrehost/public/index.html
sudo chmod -R 755 /var/www

# CREANDO VIRTUAL HOST
sudo touch /etc/apache2/sites-available/$nombrehost.conf
sudo printf "<VirtualHost *:80>\n    ServerAdmin $sadmin\n    ServerName $nombrehost\n    ServerAlias $nombrehost\n    DocumentRoot $rutapache/$nombrehost/public\n    ErrorLog ${APACHE_LOG_DIR}/error.log\n    CustomLog ${APACHE_LOG_DIR}/access.log combined\n</VirtualHost>\n" | sudo tee /etc/apache2/sites-available/$nombrehost.conf
# HABILITANDO VIRTUAL HOST
sudo a2ensite $nombrehost.conf
sudo a2dissite 000-default.conf

# REINICIANDO APACHE
sudo service apache2 restart
