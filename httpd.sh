#!/bin/bash

BASE="/usr/local/src"
HTTPD_VERSION="2.4.46"

(sudo mkdir -p ${BASE}/httpd-install \
 && cd ${BASE}/httpd-install \
 && su -c "curl -O -L https://downloads.apache.org//httpd/httpd-2.4.46.tar.gz" root \
 && sudo mkdir httpd-${HTTPD_VERSION} \
 && sudo tar -xvzf httpd-2.4.46.tar.gz -C ${BASE}/httpd-install/httpd-${HTTPD_VERSION} --strip-components 1 \
 && cd ${BASE}/httpd-install/httpd-${HTTPD_VERSION}/srclib \
 && sudo mkdir apr/ apr-util/ \
 && su -c "curl -O -L https://downloads.apache.org//apr/apr-1.7.0.tar.gz" root \
 && su -c "curl -O -L https://downloads.apache.org//apr/apr-util-1.6.1.tar.gz" root \
 && sudo tar -xvzf apr-1.7.0.tar.gz -C ${BASE}/httpd-install/httpd-${HTTPD_VERSION}/srclib/apr --strip-components 1 \
 && sudo tar -xvzf apr-util-1.6.1.tar.gz -C ${BASE}/httpd-install/httpd-${HTTPD_VERSION}/srclib/apr-util --strip-components 1 \
 && sudo ../configure --prefix=/usr/local/httpd \
	--with-included-apr \
	--enable-ssl \
	--with-ssl=/usr/local/ssl \
	--enable-ssl-staticlib-deps \
	--enable-mods-static=ssl \
	--enable-so \
	--enable-expires \
	--enable-headers \
	--enable-rewrite \
	--enable-cache \
	--enable-mem-cache \
	--enable-speling \
	--enable-usertrack \
	--enable-module=so \
	--enable-unique_id \
	--enable-logio \
 && sudo make -j4 \
 && sudo make install
)


echo "**********************************************************************START**********************************************************************"
#sleep 5

: '
sudo touch /etc/profile.d/httpd.sh

sudo mv /usr/bin/httpd /usr/bin/httpd.backup

sudo cat >/etc/profile.d/httpd.sh <<'EOL'
HTTPD_PATH="/usr/local/httpd/bin"
export HTTPD_PATH
PATH=$PATH:$HTTPD_PATH
export PATH
EOL

sudo chmod +x /etc/profile.d/httpd.sh
source /etc/profile.d/httpd.sh
'
