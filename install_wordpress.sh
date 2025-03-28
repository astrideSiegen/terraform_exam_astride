#!/bin/bash

# Variables injectées par Terraform
DB_NAME="${database_name}"
DB_USER="${database_user}"
DB_PASSWORD="${database_password}"
DB_HOST="${database_host}" # Endpoint RDS injecté

WORDPRESS_DIR="/var/www/html"

# Mettre à jour les paquets
sudo yum update -y

# Installer Apache, PHP et les modules nécessaires
sudo yum install -y httpd wget unzip php php-{pear,cgi,common,curl,mbstring,gd,mysqlnd,gettext,bcmath,json,xml,fpm,intl,zip,imap}

# Démarrer et activer Apache
sudo systemctl start httpd
sudo systemctl enable httpd

# Configurer les permissions sur le répertoire web
sudo usermod -a -G apache ec2-user
sudo chown -R ec2-user:apache $WORDPRESS_DIR
sudo chmod 2775 $WORDPRESS_DIR
find $WORDPRESS_DIR -type d -exec sudo chmod 2775 {} \;
find $WORDPRESS_DIR -type f -exec sudo chmod 0664 {} \;

# Télécharger WordPress
cd /home/ec2-user
wget https://wordpress.org/latest.zip
unzip latest.zip
mv wordpress/* $WORDPRESS_DIR

# Assigner les permissions WordPress
sudo chown -R ec2-user:apache $WORDPRESS_DIR

# Créer le fichier de configuration wp-config.php
cd $WORDPRESS_DIR
cp wp-config-sample.php wp-config.php

sed -i "s/database_name_here/$DB_NAME/" wp-config.php
sed -i "s/username_here/$DB_USER/" wp-config.php
sed -i "s/password_here/$DB_PASSWORD/" wp-config.php
sed -i "s/localhost/$DB_HOST/" wp-config.php

# Définir les bonnes permissions
sudo find $WORDPRESS_DIR -type d -exec chmod 755 {} \;
sudo find $WORDPRESS_DIR -type f -exec chmod 644 {} \;

# Redémarrer Apache
sudo systemctl restart httpd

# Affichage final
echo
echo "**************************************************************************************"
echo "******** Terraform Wordpress installation  with RDS has been executed successfully ********"
echo "**************************************************************************************"
