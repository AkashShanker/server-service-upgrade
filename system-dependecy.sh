#!/bin/bash


list=("libxml2-devel" "bzip2-devel" "libicu-devel" "g++" "gcc-c++" "make" "oniguruma-devel" "libpng-devel" "libjpeg-devel" "libzip-devel" "vim" "firewalld" "gcc" "glibc" "glibc-common" "wget" "unzip" "httpd" "php" "gd" "gd-devel" "perl" "postfix")

check_list=$(rpm -q "${list[@]}" | grep -e "not installed" | awk 'BEGIN { FS = " " } ; { printf $2" "}' > /tmp/list.txt)

install=$(cat /tmp/list.txt)

grep -q '[^[:space:]]' < /tmp/list.txt

EMPTY_FILE=$?

if [[ $EMPTY_FILE -eq 1 ]]; then
echo "Nothing to do"

else

echo "Installing: $install"
sudo yum install -y $install
fi

echo "Removing list.txt"
sleep 3
rm /tmp/list.txt


