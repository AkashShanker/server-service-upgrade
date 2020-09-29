#!/bin/bash

BASE="/usr/local/src"
PHP_VERSION="7.4.10"


(mkdir -p ${BASE}/php-install \
 && cd ${BASE}/php-install \
 && curl -O -L https://www.php.net/distributions/php-7.4.10.tar.gz \
 && mkdir php-${PHP_VERSION} \
 && tar -xvzf php-7.4.10.tar.gz -C ${BASE}/php-install/php-${PHP_VERSION} --strip-components 1 \
 && cd ${BASE}/php-install/php-${PHP_VERSION} \
 && sudo OPENSSL_CFLAGS="-I/usr/local/ssl/include/openssl" OPENSSL_LIBS="-L/usr/local/ssl/lib" CURL_CFLAGS="-I/usr/local/include" CURL_LIBS="-L/usr/local/lib -lcurl" ./configure --disable-shared --with-curl --with-openssl \
 && sudo make -j4 \
 && sudo make install
)


echo "**********************************************************************START**********************************************************************"
sleep 5

#sudo OPENSSL_CFLAGS="-I/usr/local/ssl/include/openssl" OPENSSL_LIBS="-L/usr/local/ssl/lib" CURL_CFLAGS="-I/usr/local/include" CURL_LIBS="-L/usr/local/lib -lcurl" ./configure --disable-shared --with-curl --with-openssl
sudo touch /etc/profile.d/php.sh

sudo cat >/etc/profile.d/php.sh <<EOL
PHP_PATH="/usr/local/php/bin"
export PHP_PATH
PATH=$PATH:$PHP_PATH
export PATH
EOL

sudo chmod +x /etc/profile.d/php.sh
source /etc/profile.d/php.sh

