#!/bin/bash

set -ex

BASE="/usr/local/src"
OPENSSL_VERSION="1.1.1i"
OPENSSL_VERSION_F="1_1_1i"
PREFIX="/usr/local/ssl-1.1.1i"

(mkdir -p ${BASE}/openssl-install \
 && cd ${BASE}/openssl-install \
 && curl -O -L https://github.com/openssl/openssl/archive/OpenSSL_${OPENSSL_VERSION_F}.tar.gz \
 && mkdir -p ${BASE}/openssl-install/openssl-versions/openssl-${OPENSSL_VERSION} \
 && tar -xvzf ${BASE}/openssl-install/openssl-versions/OpenSSL_${OPENSSL_VERSION_F}.tar.gz -C ${BASE}/openssl-install/openssl-versions/openssl-${OPENSSL_VERSIONS} --strip-components 1 \
 && cd ${BASE}/openssl-install/openssl-versions/openssl-${OPENSSL_VERSIONS} \
 && sudo ./config --prefix=${PREFIX} --openssldir=${PREFIX} shared zlib \
 && sudo make -j4 \
 && sudo make install
)

sudo touch /etc/ld.so.conf.d/openssl-$OPENSSL_VERSION.conf
sudo echo "$PREFIX/lib" > /etc/ld.so.conf.d/openssl-$OPENSSL_VERSION.conf
if [[ -f /etc/ld.so.conf.d/openssl-1.1.1g.conf ]]; then
	mv /etc/ld.so.conf.d/openssl-1.1.1g.conf /tmp/openssl-1.1.1g.conf
fi

sudo ldconfig -v
#sudo mv /bin/openssl /bin/openssl.backup

sudo touch /etc/profile.d/openssl-${OPENSSL_VERSION}.sh
sudo cat >/etc/profile.d/openssl-${OPENSSL_VERSION}.sh <<'EOL'
OPENSSL_PATH="/usr/local/ssl-1.1.1i/bin"
export OPENSSL_PATH
PATH=$PATH:$OPENSSL_PATH
export PATH
EOL

if [[ -f /etc/profile.d/openssl.sh  ]]; then
        mv /etc/profile.d/openssl.sh /tmp/openssl.conf
fi

#mv /etc/profile.d/openssl.sh /tmp/openssl.sh
sudo chmod +x /etc/profile.d/openssl-${OPENSSL_VERSION}.sh
source /etc/profile.d/openssl-${OPENSSL_VERSION}.sh
