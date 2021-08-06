#!/bin/bash

default="latest"
latest="1.17.1"
version=${1:-$default}

if [ $version == "latest" ]; then
    echo -e "\033[36m[INFO] Latest version is 1.17.1 \033[0m"
    version=$latest
fi

echo -e "\033[36m[INFO] Prepare to download minecraft server (version $version) \033[0m"

if [ $version == "1.17.1" ]; then
    url="https://launcher.mojang.com/v1/objects/a16d67e5807f57fc4e550299cf20226194497dc2/server.jar"
elif [ $version == "1.17" ]; then
    url="https://launcher.mojang.com/v1/objects/0a269b5f2c5b93b1712d0f5dc43b6182b9ab254e/server.jar"
elif [ $version == "1.16.5" ]; then
    url="https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar"
elif [ $version == "1.15.2" ]; then
    url="https://launcher.mojang.com/v1/objects/bb2b6b1aefcd70dfd1892149ac3a215f6c636b07/server.jar"
elif [ $version == "1.14.4" ]; then
    url="https://launcher.mojang.com/v1/objects/3dc3d84a581f14691199cf6831b71ed1296a9fdf/server.jar"
elif [ $version == "1.13.2" ]; then
    url="https://launcher.mojang.com/v1/objects/3737db93722a9e39eeada7c27e7aca28b144ffa7/server.jar"
else
    echo -e "\033[31m[ERROR] Unsupported version. \033[0m"
    exit 1
fi

# download
wget -O ./server.jar $url
echo -e "\033[33m[SUCCESS] server.jar already downloaded. \033[0m"
