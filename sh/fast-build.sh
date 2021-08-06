#!/bin/bash

# Global variables
default_memory=2 #GB
default_filename=server.jar
default_version=1.17.1

# ==========================================================
# check Java and screen

# check Java version
echo -e "\033[36m[INFO] Checking Java... \033[0m"
java -version

# if the command above execute failed, download the latest version of JDK
if [ $? -eq 0 ]; then
    echo -e "\033[36m[INFO] Java is installed. \033[0m"
else
    # install JDK 16 (for 1.17)
    echo -e "\033[36m[INFO] Java isn't installed. Start installing... \033[0m"
    sudo apt-get install openjdk-16-jdk -y
    if [ $? -eq 0 ]; then
        echo -e "\033[33m[SUCCESS] Java installed successfully. \033[0m"
    else
        echo -e "\033[31m[ERROR] Java installed failed. \033[0m"
        exit 1
    fi
fi

# check screen installed
echo -e "\033[36m[INFO] Checking screen... \033[0m"
screen -version

# if the command above execute failed, install screen
if [ $? -eq 0 ]; then
    echo -e "\033[36m[INFO] screen is installed. \033[0m"
else
    echo -e "\033[36m[INFO] screen isn't installed. Start installing... \033[0m"
    sudo apt-get install screen -y 
    if [ $? -eq 0 ]; then
        echo -e "\033[33m[SUCCESS] screen installed successfully. \033[0m"
    else
        echo -e "\033[31m[ERROR] screen installed failed. \033[0m"
        exit 1
    fi
fi   

# ==========================================================
# get server file
echo -e "\033[36m[INFO] Prepare to download minecraft server (version $default_version) \033[0m"

if [ $default_version == "1.17.1" ]; then
    url="https://launcher.mojang.com/v1/objects/a16d67e5807f57fc4e550299cf20226194497dc2/server.jar"
elif [ $default_version == "1.17" ]; then
    url="https://launcher.mojang.com/v1/objects/0a269b5f2c5b93b1712d0f5dc43b6182b9ab254e/server.jar"
elif [ $default_version == "1.16.5" ]; then
    url="https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar"
elif [ $default_version == "1.15.2" ]; then
    url="https://launcher.mojang.com/v1/objects/bb2b6b1aefcd70dfd1892149ac3a215f6c636b07/server.jar"
elif [ $default_version == "1.14.4" ]; then
    url="https://launcher.mojang.com/v1/objects/3dc3d84a581f14691199cf6831b71ed1296a9fdf/server.jar"
elif [ $default_version == "1.13.2" ]; then
    url="https://launcher.mojang.com/v1/objects/3737db93722a9e39eeada7c27e7aca28b144ffa7/server.jar"
else
    echo -e "\033[31m[ERROR] Unsupported version. \033[0m"
    exit 1
fi

# download
wget -O ./server.jar $url
echo -e "\033[33m[SUCCESS] server.jar already downloaded. \033[0m"

# ==========================================================
# test screen session "mc" exist
screen -r mc -X stuff "echo test\n"

# if the command above execute failed, create a detached screen
if [ ! $? -eq 0 ]; then
    screen -dmS mc
fi

# ==========================================================
# initialize eula.txt
echo "eula=true\n" > eula.txt
echo -e "\033[36m[INFO] File eula.txt added. \033[0m"

# run server.jar for initialize files
mb=$(expr $gb \* 1024)M

echo -e "\033[36m[INFO] Starting server with memory $gb GB... \033[0m"
sleep 1s

# start server
screen -r mc -X stuff "java -Xmx$mb -Xms$mb -jar $filename nogui\n"

echo -e "\033[33mServer has already started at a detached screen 'mc'. \033[0m"
echo -e "\033[33mUse 'screen -r mc' to get into the screen. (Use Ctrl + A + D to leave) \033[0m"