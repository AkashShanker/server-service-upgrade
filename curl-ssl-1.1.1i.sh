#!/bin/bash


set -ex

BASE="/usr/local/src"
CURL_VERSION="7.72.0"
OPENSSL_VERSION="1.1.1i"

(mkdir -p ${BASE}/curl-install \
 && cd ${BASE}/curl-install \
 && curl -O -L https://curl.haxx.se/download/curl-7.72.0.tar.gz \
 && mkdir -p curl-${CURL_VERSION}-ssl-${OPENSSL_VERSION} \
 && tar -xvzf curl-7.72.0.tar.gz -C ${BASE}/curl-install/curl-${CURL_VERSION}-ssl-${OPENSSL_VERSION} --strip-components 1 \
 && cd ${BASE}/curl-install/curl-${CURL_VERSION}-ssl-${OPENSSL_VERSION} \
 && sudo ./configure --prefix=/usr/local/curl-versions/curl-${CURL_VERSION}-ssl-${OPENSSL_VERSION} --with-ssl=/usr/local/ssl-versions/ssl-1.1.1i \
 && sudo make -j4 \
 && sudo make install
)

#sleep 5

sudo touch /etc/profile.d/curl-${CURL_VERSION}-ssl-${OPENSSL_VERSION}.sh

#sudo mv /usr/bin/curl /usr/bin/curl.backup

sudo cat >/etc/profile.d/curl-${CURL_VERSION}-ssl-${OPENSSL_VERSION}.sh <<'EOL'
CURL_PATH="/usr/local/curl-versions/curl-7.72.0-ssl-1.1.1i/bin"
export CURL_PATH
PATH=$PATH:$CURL_PATH
export PATH
EOL

sudo chmod +x /etc/profile.d/curl-${CURL_VERSION}-ssl-${OPENSSL_VERSION}.sh
source /etc/profile.d/curl-${CURL_VERSION}-ssl-${OPENSSL_VERSION}.sh

