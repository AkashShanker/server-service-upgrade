#!/bin/bash

set -ex

BASE="/usr/local/src"
PHP_VERSION="7.4.10"
OPENSSL_VERSION="1.1.1i"

(mkdir -p ${BASE}/php-install \
 && cd ${BASE}/php-install \
 && curl -O -L https://www.php.net/distributions/php-7.4.10.tar.gz \
 && mkdir -p php-${PHP_VERSION}-ssl-${OPENSSL_VERSION} \
 && tar -xvzf php-7.4.10.tar.gz -C ${BASE}/php-install/php-${PHP_VERSION}-ssl-${OPENSSL_VERSION} --strip-components 1 \
 && cd ${BASE}/php-install/php-${PHP_VERSION}-ssl-${OPENSSL_VERSION} \
 && sudo OPENSSL_CFLAGS="-I/usr/local/ssl-versions/ssl-1.1.1i/include" OPENSSL_LIBS="-L/usr/local/ssl-versions/ssl-1.1.1i/lib" CURL_CFLAGS="-I/usr/local/curl-versions/curl-7.72.0-ssl-1.1.1i/include" CURL_LIBS="-L/usr/local/curl-versions/curl-7.72.0-ssl-1.1.1i/lib -lcurl" ./configure --prefix=/usr/local/php-versions/php-${PHP_VERSION}-ssl-${OPENSSL_VERSION} --disable-shared --with-openssl --with-curl --with-apxs2=/usr/local/httpd-versions/httpd-2.4.46-ssl-1.1.1i/bin/apxs \
 && sudo make -j4 \
 && sudo make install
)


#sudo OPENSSL_CFLAGS="-I/usr/local/ssl/include/openssl" OPENSSL_LIBS="-L/usr/local/ssl/lib" CURL_CFLAGS="-I/usr/local/include" CURL_LIBS="-L/usr/local/lib -lcurl" ./configure --disable-shared --with-curl --with-openssl

sudo touch /etc/profile.d/php-${PHP_VERSION}-ssl-${OPENSSL_VERSION}.sh

sudo cat >/etc/profile.d/php-${PHP_VERSION}-ssl-${OPENSSL_VERSION}.sh <<EOL
PHP_PATH="/usr/local/php-versions/php-${PHP_VERSION}-ssl-${OPENSSL_VERSION}/bin"
export PHP_PATH
PATH=$PATH:$PHP_PATH
export PATH
EOL

sudo chmod +x /etc/profile.d/php-${PHP_VERSION}-ssl-${OPENSSL_VERSION}
source /etc/profile.d/php-${PHP_VERSION}-ssl-${OPENSSL_VERSION}

