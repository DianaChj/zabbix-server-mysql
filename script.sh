#!/bin/bash
service mysql start
mysql -u root -e "CREATE DATABASE zabbix character set utf8 collate utf8_bin;"
mysql -u root -e "GRANT ALL PRIVILEGES on zabbix.* to zabbix@localhost IDENTIFIED BY 'password';"
#mysql -u root -e "FLUSH PRIVILEGES;"
zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -uzabbix -ppassword zabbix

service zabbix-server start
service zabbix-agent start
service apache2 start


