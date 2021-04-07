#!/bin/bash

BASE="/usr/local/src"
CURL_VERSION="7.72.0"


(mkdir -p ${BASE}/curl-install \
 && cd ${BASE}/curl-install \
 && curl -O -L https://curl.haxx.se/download/curl-7.72.0.tar.gz \
 && mkdir -p ${BASE}/curl-install/curl-versions/curl-${CURL_VERSION} \
 && tar -xvzf curl-7.72.0.tar.gz -C ${BASE}/curl-install/curl-versions/curl-${CURL_VERSION} --strip-components 1 \
 && cd ${BASE}/curl-install/curl-versions/curl-${CURL_VERSION} \
 && sudo ./configure --prefix=/usr/local/curl --with-ssl=/usr/local/ssl \
 && sudo make -j4 \
 && sudo make install
)


echo "**********************************************************************START**********************************************************************"
sleep 5


sudo touch /etc/profile.d/curl.sh

sudo mv /usr/bin/curl /usr/bin/curl.backup

sudo cat >/etc/profile.d/curl.sh <<'EOL'
CURL_PATH="/usr/local/curl/bin"
export CURL_PATH
PATH=$PATH:$CURL_PATH
export PATH
EOL

sudo chmod +x /etc/profile.d/curl.sh
source /etc/profile.d/curl.sh

