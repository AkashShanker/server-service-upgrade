#!/bin/bash

set -ex

BASE="/usr/local/src"
HTTPD_VERSION="2.4.46"
OPENSSL_PATH="/usr/local/ssl-versions/ssl-1.1.1i/bin/openssl"
OPENSSL_VERSION="1.1.1i"


(sudo mkdir -p ${BASE}/httpd-install \
 && cd ${BASE}/httpd-install \
 && curl -O -L https://downloads.apache.org//httpd/httpd-2.4.46.tar.gz \
 && mkdir -p httpd-${HTTPD_VERSION}-ssl-${OPENSSL_VERSION} \
 && sudo tar -xvzf httpd-2.4.46.tar.gz -C ${BASE}/httpd-install/httpd-${HTTPD_VERSION}-ssl-${OPENSSL_VERSION} --strip-components 1 \
 && cd ${BASE}/httpd-install/httpd-${HTTPD_VERSION}-ssl-${OPENSSL_VERSION}/srclib \
 && sudo mkdir -p apr/ apr-util/ \
 && curl -O -L https://downloads.apache.org//apr/apr-1.7.0.tar.gz \
 && curl -O -L https://downloads.apache.org//apr/apr-util-1.6.1.tar.gz \
 && sudo tar -xvzf apr-1.7.0.tar.gz -C ${BASE}/httpd-install/httpd-${HTTPD_VERSION}-ssl-${OPENSSL_VERSION}/srclib/apr --strip-components 1 \
 && sudo tar -xvzf apr-util-1.6.1.tar.gz -C ${BASE}/httpd-install/httpd-${HTTPD_VERSION}-ssl-${OPENSSL_VERSION}/srclib/apr-util --strip-components 1 \
 && sudo ../configure --prefix=/usr/local/httpd-versions/httpd-${HTTPD_VERSION}-ssl-${OPENSSL_VERSION} \
	--with-included-apr \
	--enable-ssl \
	--with-ssl=${OPENSSL_PATH} \
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

sudo touch /etc/profile.d/httpd-${HTTPD_VERSION}-ssl-${OPENSSL_VERSION}.sh

sudo cat >/etc/profile.d/httpd-${HTTPD_VERSION}-ssl-${OPENSSL_VERSION}.sh <<'EOL'
HTTPD_PATH="/usr/local/httpd-versions/httpd-${HTTPD_VERSION}-ssl-${OPENSSL_VERSION}/bin"
export HTTPD_PATH
PATH=$PATH:$HTTPD_PATH
export PATH
EOL

#sudo chmod +x /etc/profile.d/httpd-${HTTPD_VERSION}-ssl-${OPENSSL_VERSION}.sh

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
