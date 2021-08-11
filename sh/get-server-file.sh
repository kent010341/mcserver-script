#!/bin/bash

default="latest"
latest="1.17.1"
version=${1:-$default}

if [ $version == "latest" ]; then
    echo -e "\033[1;96m[INFO] Latest version is 1.17.1 \033[0m"
    version=$latest
fi

echo -e "\033[1;96m[INFO] Prepare to download minecraft server (version $version) \033[0m"

version_file_url="https://raw.githubusercontent.com/kent010341/mcserver-script/master/sh/source/version-hash.txt"
version_hash_key=$(curl $version_file_url | grep "$version=" | cut -d">" -f 2)

if [ "$version_hash_key" == "" ]; then
    echo -e "\033[1;91m[ERROR] Unsupported version. \033[0m"
    exit 1
fi

url="https://launcher.mojang.com/v1/objects/$version_hash_key/server.jar"

# download
wget -O ./server.jar $url
echo -e "\033[1;93m[SUCCESS] server.jar already downloaded. \033[0m"
