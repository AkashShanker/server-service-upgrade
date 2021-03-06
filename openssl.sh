#!/bin/bash

BASE="/usr/local/src"
OPENSSL_VERSION="1.1.1j"

(mkdir -p ${BASE}/openssl-install \
 && cd ${BASE}/openssl-install \
 && curl -O -L https://github.com/openssl/openssl/archive/OpenSSL_1_1_1j.tar.gz \
 && mkdir -p ${BASE}/openssl-install/openssl-versions/openssl-${OPENSSL_VERSION} \
 && tar -xvzf ${BASE}/openssl-install/OpenSSL_1_1_1j.tar.gz -C ${BASE}/openssl-install/openssl-versions/openssl-${OPENSSL_VERSION} --strip-components 1 \
 && cd ${BASE}/openssl-install/openssl-versions/openssl-${OPENSSL_VERSION} \
 && sudo ./config --prefix=/usr/local/ssl-versions/openssl-${OPENSSL_VERSION} --openssldir=/usr/local/ssl shared zlib \
 && sudo make -j4 \
 && sudo make install
)

sudo touch /etc/ld.so.conf.d/openssl-$OPENSSL_VERSION.conf
sudo echo "/usr/local/ssl-versions/openssl-1.1.1j/lib" > /etc/ld.so.conf.d/openssl-${OPENSSL_VERSION}.conf
sudo ldconfig -v
sudo mv /bin/openssl /bin/openssl.backup

sudo touch /etc/profile.d/openssl-${OPENSSL_VERSION}.sh
sudo cat >/etc/profile.d/openssl.sh <<'EOL'
OPENSSL_PATH="/usr/local/ssl-versions/openssl-1.1.1j/bin"
export OPENSSL_PATH
PATH=$PATH:$OPENSSL_PATH
export PATH
EOL

sudo chmod +x /etc/profile.d/openssl-${OPENSSL_VERSION}.sh
source /etc/profile.d/openssl.sh




