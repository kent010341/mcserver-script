#!/bin/bash

# Global variables
default_memory=2 #GB
default_version=1.18

while (($#)); do
    case $1 in
        "--memory")
            shift
            default_memory=$1
            shift
        ;;
        "--version")
            shift
            default_version=$1
            shift
        ;;
        "--help")
            echo "Usage: ./fast-build.sh [options...]"
            echo "    --memory <memory>         RAM used for the server (in GB)"
            echo "    --version <version>       Minecraft server version"
            exit 1
        ;;
        *)
            echo "unknown argument '$1'"
            echo "Use --help to get the usage information."
            exit 1
        ;;
    esac
done

# ==========================================================
# check Java and screen

# check Java version
echo -e "\033[1;96m[INFO] Checking Java... \033[0m"
java -version

# if the command above execute failed, download the latest version of JDK
if [ $? -eq 0 ]; then
    echo -e "\033[1;96m[INFO] Java is installed. \033[0m"
else
    # install JRE of Java 17 (for 1.18)
    echo -e "\033[1;96m[INFO] Java isn't installed. Start installing... \033[0m"
    sudo apt-get install openjdk-17-jre -y
    if [ $? -eq 0 ]; then
        echo -e "\033[1;93m[SUCCESS] Java installed successfully. \033[0m"
    else
        echo -e "\033[1;91m[ERROR] Java installed failed. \033[0m"
        exit 1
    fi
fi

# check screen installed
echo -e "\033[1;96m[INFO] Checking screen... \033[0m"
screen -version

# if the command above execute failed, install screen
if [ $? -eq 0 ] || [ $? -eq 1 ]; then
    echo -e "\033[1;96m[INFO] screen is installed. \033[0m"
else
    echo -e "\033[1;96m[INFO] screen isn't installed. Start installing... \033[0m"
    sudo apt-get install screen -y 
    if [ $? -eq 0 ]; then
        echo -e "\033[1;93m[SUCCESS] screen installed successfully. \033[0m"
    else
        echo -e "\033[1;91m[ERROR] screen installed failed. \033[0m"
        exit 1
    fi
fi   

# ==========================================================
# get server file
if [ -f "server.jar" ]; then
    echo -e "\033[1;96m[INFO] server.jar already exists. \033[0m"
else
    echo -e "\033[1;96m[INFO] Prepare to download minecraft server (version $default_version) \033[0m"

    version_file_url="https://raw.githubusercontent.com/kent010341/mcserver-script/master/sh/source/version-hash.txt"
    version_hash_key=$(curl --silent $version_file_url | grep "$default_version=" | cut -d">" -f 2)

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
            exit 1
        fi
    fi
fi

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
echo -e "\033[1;96m[INFO] File eula.txt added. \033[0m"

# run server.jar for initialize files
gb=$default_memory
mb=$(expr $gb \* 1024)M

echo -e "\033[1;96m[INFO] Starting server with memory $gb GB... \033[0m"
sleep 1s

# start server
screen -r mc -X stuff "java -Xmx$mb -Xms$mb -jar ./server.jar nogui\n"

echo -e "\033[1;93m[SUCCESS] Server has already started at a detached screen 'mc'. \033[0m"
echo -e "\033[1;93m[SUCCESS] Use 'screen -r mc' to get into the screen. (Use Ctrl + A + D to leave) \033[0m"
