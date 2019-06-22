#!/bin/bash
echo '[mysql]
socket=/var/run/mariaDB/mysql.sock
[mysqld]
bind-address=0.0.0.0
basedir=/usr/local/mariaDB
datadir=/vagrant/data
socket=/var/run/mariaDB/mysql.sock
user=www
# Disabling symbolic-links is recommended to prevent assorted security risks
symbolic-links=0
explicit_defaults_for_timestamp=1
secure_file_priv=/tmp
skip-ssl
slow_query_log=1
long_query_time=1
log_queries_not_using_indexes=1
#slow_query_log_file=/var/lib/mysql/slow-query.log
log_output=TABLE
#general_log=on
#general_log_file=/var/log/mysql/query.log
pid-file=/var/run/mariaDB/mysqld.pid
log-error=/var/log/mariaDB.log' > /etc/my.cnf

ln -s /usr/local/mariaDB/support-files/mysql.server /etc/init.d/mariadb

cd /usr/local/mariaDB

/usr/local/mariaDB/scripts/mysql_install_db --user=www --basedir=/usr/local/mariaDB --datadir=/vagrant/data

chkconfig --add mariadb

service mariadb start

echo "mysql_secure_installation"

yum install -y expect

/usr/bin/expect <<EOF
set time 10
spawn /usr/local/mariaDB/bin/mysql_secure_installation
expect {
        "server through socket" {exit 1}
        "(enter for none)" { send "asdfasdf\r"; exp_continue}
        "Y/n" { send "Y\r"; exp_continue}
        "New password" { send "asdfasdf\r"; exp_continue}
        "Re-enter new password" { send "asdfasdf\r"; exp_continue}
        "Access denied" { exit 2}
}
EOF