FROM ubuntu:16.04
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    tzdata \
    wget \
    apache2 \ 
    libapache2-mod-php \
    mysql-server mysql-client \
    php php-mbstring php-gd php-xml php-bcmath php-ldap php-mysql && \  
    wget https://repo.zabbix.com/zabbix/4.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_4.2-1+xenial_all.deb && \
    dpkg -i zabbix-release_4.2-1+xenial_all.deb && \
    apt-get update && apt-get install -y --no-install-recommends\ 
    zabbix-server-mysql \
    zabbix-frontend-php \
    zabbix-agent \
&& rm -rf /var/lib/apt/lists/*
COPY script.sh /script.sh

RUN sed 's/# DBPassword/DBPassword=password/g' /etc/zabbix/zabbix_server.conf && \
    sed 's+# php_value date.timezone Europe/Riga+php_value date.timezone Europe/Riga+g' /etc/zabbix/apache.conf && \
    service zabbix-server restart && \
    service zabbix-agent restart && \
    service apache2 restart
CMD /script.sh ; sleep infinity
