FROM ubuntu:18.04
RUN apt-get update
RUN apt-get install -y tzdata
RUN apt-get -y install wget
RUN apt-get -y install apache2 libapache2-mod-php
RUN apt-get -yq install mysql-server mysql-client
RUN apt-get -y install php php-mbstring php-gd php-xml php-bcmath php-ldap php-mysql
RUN wget https://repo.zabbix.com/zabbix/4.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_4.2-1+bionic_all.deb
RUN dpkg -i zabbix-release_4.2-1+bionic_all.deb
RUN apt-get update
RUN apt-get -y install zabbix-server-mysql zabbix-frontend-php zabbix-agent
RUN wget http://repo.zabbix.com/zabbix/4.2/ubuntu/pool/main/z/zabbix/zabbix-server-mysql_4.2.4-1+bionic_amd64.deb
RUN dpkg -x zabbix-server-mysql_4.2.4-1+bionic_amd64.deb /
COPY script.sh /script.sh

RUN sed 's/# DBPassword/DBPassword=password/g' /etc/zabbix/zabbix_server.conf
RUN sed 's+# php_value date.timezone Europe/Riga+php_value date.timezone Europe/Riga+g' /etc/zabbix/apache.conf
#RUN service zabbix-server restart
#RUN service zabbix-agent restart
#RUN service apache2 restart

CMD /script.sh ; sleep infinity
