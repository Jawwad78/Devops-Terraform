#cloud-config

#install apche first and packages (make into a list with a dash and space at beginning)
packages:
- apache2
- php8.3
- libapache2-mod-php8.3
- php8.3-mysql
- php8.3-curl
- php8.3-xml
- php8.3-exif
- php8.3-fileinfo
- php-igbinary
- php-imagick
- php8.3-intl
- php8.3-mbstring
- php8.3-zip

#now I will do runcmd because thats needed now to download,edit etc so all below will use runcmd only (amazing right lol)

# I then done these setps
# Download  WordPress
# Clean up default page, set permissions, and switch to WordPress root
# I used string format (first did list but was confused)
# Configure the wp-config file so its links to my DB
# Restart Apache

runcmd:
- cd /tmp && curl -LO https://wordpress.org/latest.tar.gz       
- tar xzvf latest.tar.gz
- sudo mv wordpress/* /var/www/html/
- sudo rm -f /var/www/html/index.html
- sudo chown -R www-data:www-data /var/www/html/
- sudo chmod -R 755 /var/www/html/
- cd /var/www/html
- sudo mv wp-config-sample.php wp-config.php
- sudo sed -i "s/database_name_here/${db_name}/" wp-config.php
- sudo sed -i "s/username_here/${db_user}/" wp-config.php
- sudo sed -i "s/password_here/${db_password}/" wp-config.php
- sudo sed -i "s/localhost/${db_host}/" wp-config.php
- sudo systemctl restart apache2
