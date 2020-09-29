#!/bin/bash


BASE="/usr/local/src"
OPENSSL_VERSION="1.1.1g"


(mkdir -p ${BASE}/openssl-install \
 && cd ${BASE}/openssl-install \
 && curl -O -L https://github.com/openssl/openssl/archive/OpenSSL_1_1_1g.tar.gz \
 && mkdir ${BASE}/openssl-install/openssl \
 && tar -xvzf ${BASE}/openssl-install/OpenSSL_1_1_1g.tar.gz -C ${BASE}/openssl-install/openssl --strip-components 1 \
 && cd ${BASE}/openssl-install/openssl \
 && sudo ./config --prefix=/usr/local/ssl --openssldir=/usr/local/ssl shared zlib \
 && sudo make -j4 \
 && sudo make install
)

sudo touch /etc/ld.so.conf.d/openssl-$OPENSSL_VERSION.conf
sudo echo "/usr/local/ssl/lib" > /etc/ld.so.conf.d/openssl-$OPENSSL_VERSION.conf
sudo ldconfig -v
sudo mv /bin/openssl /bin/openssl.backup


sudo touch /etc/profile.d/openssl.sh
sudo cat >/etc/profile.d/openssl.sh <<EOL
OPENSSL_PATH="/usr/local/ssl/bin"
export OPENSSL_PATH
PATH=$PATH:$OPENSSL_PATH
export PATH
EOL

sudo chmod +x /etc/profile.d/openssl.sh
source /etc/profile.d/openssl.sh




