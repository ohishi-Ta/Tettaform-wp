#!/bin/bash
yum update -y

##php
amazon-linux-extras install php7.2 -y
yum -y install mysql httpd php-mbstring php-xml

##wp
wget http://ja.wordpress.org/latest-ja.tar.gz -P /tmp/
tar zxvf /tmp/latest-ja.tar.gz -C /tmp
cp -r /tmp/wordpress/* /var/www/html/

## Apache　Setup
chown -R apache:apache /var/www/html
systemctl start httpd
systemctl enable httpd