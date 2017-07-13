#!/bin/bash
sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update
sudo apt-get install python-certbot-apache phpmyadmin php-mbstring php-gettext apache2-utils fail2ban sendmail iptables-persistent
sudo certbot --apache -d fenbranklin.ddns.net
echo "15 3 * * * /usr/bin/certbot renew --quiet" >> mycron
sudo crontab mycron
rm mycron
sudo phpenmod mcrypt
sudo phpenmod mbstring
sudo systemctl restart apache2
echo "Add AllowOverride All to <Directory /usr/share/phpmyadmin>"
read -n1 -r -p "Press space to continue..." key
sudo nano /etc/apache2/conf-available/phpmyadmin.conf
sudo systemctl restart apache2
echo "AuthType Basic" > myhtaccess
echo 'AuthName "Restricted Files"' >> myhtaccess
echo "AuthUserFile /etc/phpmyadmin/.htpasswd" >> myhtaccess
echo "Require valid-user" >> myhtaccess
sudo cat myhtaccess > /usr/share/phpmyadmin/.htaccess
rm myhtaccess
echo ***PUT SOME PASSWORD HERE ***
sudo htpasswd -c /etc/phpmyadmin/.htpasswd secureuser
sudo mysql_secure_installation
echo "Don't forget to edit mysql.cnf to allow remote access from your local workstation."
echo "bind-address=127.0.0.1"
#ASCII art is optional.
sudo chmod -x /etc/update-motd.d/10-help-text
sudo echo "·▄▄▄▄  ▄▄▄ .▄▄▄ . ▄▄▄·▄▄▄▄▄ ▄ .▄      ▄• ▄▌ ▄▄ •  ▄ .▄▄▄▄▄▄" >> /etc/update-motd.d/98-deep
sudo echo "██▪ ██ ▀▄.▀·▀▄.▀·▐█ ▄█•██  ██▪▐█▪     █▪██▌▐█ ▀ ▪██▪▐█•██  "; >> /etc/update-motd.d/98-deep
sudo echo "▐█· ▐█▌▐▀▀▪▄▐▀▀▪▄ ██▀· ▐█.▪██▀▐█ ▄█▀▄ █▌▐█▌▄█ ▀█▄██▀▐█ ▐█.▪"; >> /etc/update-motd.d/98-deep
sudo echo "██. ██ ▐█▄▄▌▐█▄▄▌▐█▪·• ▐█▌·██▌▐▀▐█▌.▐▌▐█▄█▌▐█▄▪▐███▌▐▀ ▐█▌·"; >> /etc/update-motd.d/98-deep
sudo echo "▀▀▀▀▀•  ▀▀▀  ▀▀▀ .▀    ▀▀▀ ▀▀▀ · ▀█▄▀▪ ▀▀▀ ·▀▀▀▀ ▀▀▀ · ▀▀▀ "; >> /etc/update-motd.d/98-deep
