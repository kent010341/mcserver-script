#!/bin/bash

default="latest"
version=${1:-$default}
version_file_url="https://raw.githubusercontent.com/kent010341/mcserver-script/master/sh/source/version-hash.txt"

if [ $version == "--help" ] | [ $version == "-h" ]; then
    echo "Usage: ./get-server-file.sh [version]"
    echo "    By default, the version is $latest"
    exit 1
fi

response=$(curl --silent $version_file_url)

if [ $version == "latest" ]; then
    version=$(echo "$response" | grep "latest=" | cut -d">" -f 2)
    echo -e "\033[1;96m[INFO] Latest version is $version \033[0m"
fi

echo -e "\033[1;96m[INFO] Prepare to download minecraft server (version $version) \033[0m"

version_hash_key=$(echo "$response" | grep "$version=" | cut -d">" -f 2)

if [ "$version_hash_key" == "" ]; then
    echo -e "\033[1;91m[ERROR] Unsupported version. \033[0m"
    exit 1
fi

url="https://launcher.mojang.com/v1/objects/$version_hash_key/server.jar"

# download
wget -O ./server.jar $url

if [ $? -eq 0 ]; then
    echo -e "\033[1;93m[SUCCESS] server.jar already downloaded. \033[0m"
else
    echo -e "\033[1;91m[WARNING] Download process using wget failed. Use curl instead. \033[0m"
    curl $url --silent -o ./server.jar
    if [ $? -eq 0 ]; then
        echo -e "\033[1;93m[SUCCESS] server.jar already downloaded. \033[0m"
    else
        echo -e "\033[1;91m[ERROR] Download server.jar failed. \033[0m"
    fi
fi
