yum install gcc cmake

mkdir ~/openssl-install && cd ~/openssl-install
#wget https://www.openssl.org/source/openssl-1.1.1g.tar.gz
curl -O -L https://github.com/openssl/openssl/archive/OpenSSL_1_1_1g.tar.gz
tar -xzvf OpenSSL_1_1_1g.tar.gz
cd openssl-OpenSSL_1_1_1g/


sudo ./config --prefix=/usr/local/ssl --openssldir=/usr/local/ssl shared zlib
sudo make -j4
sudo make install

cd /etc/ld.so.conf.d
sudo touch openssl-1.1.1g.conf

sudo echo "/usr/local/ssl/lib" >> openssl-1.1.1g.conf

sudo ldconfig -v

sudo mv /bin/openssl /bin/openssl.backup

sudo touch /etc/profile.d/openssl.sh

sudo cat >/etc/profile.d/openssl.sh <<EOL
OPENSSL_PATH="/usr/local/ssl/bin"
export OPENSSL_PATH
PATH=$PATH:$OPENSSL_PATH
export PATH

EOL

sudo cat >/etc/profile.d/curl.sh <<EOL
OPENSSL_PATH="/usr/local/bin"
export OPENSSL_PATH
PATH=$PATH:$OPENSSL_PATH
export PATH

EOL
sudo chmod +x /etc/profile.d/openssl.sh

source /etc/profile.d/openssl.sh
echo $PATH




cd /usr/local/src/
sudo wget https://www.openssl.org/source/openssl-1.1.1c.tar.gz

sudo tar -xf openssl-1.1.1c.tar.gz

#sudo sh -c "echo '/usr/local/openssl/lib/' >> /etc/ld.so.conf.d/openssl.conf"


