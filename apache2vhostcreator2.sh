#PAQUETES NECESARIOS
sudo apt-get install -y apache2

# ESTABLECIENDO VARIABLES
rutapache=/var/www

newHost(){
        nombrehost=$1
        puertohost=$2
        sadmin=$3

        # CREANDO ESTRUCTURA DE DIRECTORIOS
                sudo mkdir -p $rutapache/$nombrehost/public
                sudo mkdir -p $rutapache/$nombrehost/session
                sudo mkdir -p $rutapache/$nombrehost/logs
                sudo chown -R $USER:$USER $rutapache/$nombrehost/public
                sudo chmod -R 755 /var/www
        # CREANDO PAGINA DE EJEMPLO
                #sudo touch $rutapache/$nombrehost/public/index.html
                #sudo printf "\n\n<html><head><title>¡Bienvenido a $nombrehost! </title></head><body><h1>Lo lograste! El virtual host $nombrehost est&aacute; funcionando</h1></body></html>\n\n" | sudo tee $rutapache/$nombrehost/public/index.html
                sudo chmod -R 755 /var/www
        # CREANDO VIRTUAL HOST
                sudo printf "<VirtualHost *:$puertohost>\n    ServerAdmin $sadmin\n    ServerName $nombrehost\n    ServerAlias $nombrehost\n    DocumentRoot $rutapache/$nombrehost/public\n" | sudo tee /etc/apache2/sites-available/$nombrehost.conf
                sudo printf "    ErrorLog $rutapache/$nombrehost/logs/error.log\n    CustomLog $rutapache/$nombrehost/logs/access.log combined\n" | sudo tee -a /etc/apache2/sites-available/$nombrehost.conf
                sudo printf "\n\n    ErrorDocument 404 /404.html\n    ErrorDocument 401 /401.html\n    ErrorDocument 500 /50x.html\n    ErrorDocument 502 /50x.html\n    ErrorDocument 503 /50x.html\n    ErrorDocument 504 /50x.html\n</VirtualHost>\n\n\n" | sudo tee -a /etc/apache2/sites-available/$nombrehost.conf
                sudo printf "Listen $puertohost\n" | sudo tee -a /etc/apache2/ports.conf
                sudo a2ensite $nombrehost.conf
        # REINICIANDO APACHE
                sudo service apache2 restart
}

newHost $1 $2 $3
