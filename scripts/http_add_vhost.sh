#! /bin/bash
if [ $# -eq 0 ]
 then
	echo "No arguments supplied" >& 2
	exit 1
fi

if [ "$(id -u)" -ne 0 ]; then
        echo "This script must be run by root" >&2
        exit 1
fi

function extract_string(){
    DELIMETER=$1
    STRING=$2
    INDEX=$3
    IFS=$DELIMETER
    read -ra NAMES <<< $STRING
    SUBDOMAIN=${NAMES[$INDEX]}
    echo $SUBDOMAIN
}

FQDN=$1
VHOST=$(extract_string '.' $FQDN 0)
SUBDOMAIN=$(extract_string '.' $FQDN 1)
SUBDOMAINFILE="/etc/bind/mrt-tests/db."$SUBDOMAIN

#if [ -e "/etc/bind/mrt-tests/db.$SUBDOMAIN" ]
# then
	touch /etc/apache2/sites-available/$VHOST.conf
	FILE="/etc/apache2/sites-available/"$VHOST".conf"
	echo "<VirtualHost *:80>" >>  $FILE
	echo "	ServerAdmin webmaster@localhost" >> $FILE
	echo "	ServerName" $VHOST"."$SUBDOMAIN".sb.uclllabs.be" >> $FILE
	echo "	ServerAlias" $VHOST"."$SUBDOMAIN".sb.uclllabs.be" >> $FILE
	echo "	DocumentRoot /var/www/html/"$VHOST >> $FILE
	echo "	ErrorLog \${APACHE_LOG_DIR}/"$VHOST"-error.log" >> $FILE
	echo "	CustomLog \${APACHE_LOG_DIR}/"$VHOST"-acces.log combined" >> $FILE
	echo "</VirtualHost>" >> $FILE

	mkdir /var/www/html/$VHOST
	touch /var/www/html/$VHOST/index.html
	INDEXFILE="/var/www/html/"$VHOST"/index.html"

	echo "<html>" >> $INDEXFILE
	echo "<head>" >> $INDEXFILE
	echo "</head>" >> $INDEXFILE
	echo "<body>" >> $INDEXFILE
	echo "<p> welcome "$VHOST"."$SUBDOMAIN"</p>" >> $INDEXFILE
	echo "</body>" >> $INDEXFILE
	echo "</html>" >> $INDEXFILE
	echo "everything was executed"
#fi

	a2ensite $VHOST.conf
	systemctl reload apache2
echo "vhost: " $VHOST
echo "sub: " $SUBDOMAIN


