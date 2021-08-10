#!/bin/bash

# check Java version
echo -e "\033[1;96m[INFO] Checking Java... \033[0m"
java -version

# if the command above execute failed, download the latest version of JDK
if [ $? -eq 0 ]; then
    echo -e "\033[1;96m[INFO] Java is installed. \033[0m"
else
    # install JDK 16 (for 1.17)
    echo -e "\033[1;96m[INFO] Java isn't installed. Start installing... \033[0m"
    sudo apt-get install openjdk-16-jdk -y
    if [ $? -eq 0 ]; then
        echo -e "\033[1;93m[SUCCESS] Java installed successfully. \033[0m"
    else
        echo -e "\033[1;91m[ERROR] Java installed failed. \033[0m"
    fi
fi

if [ $1 == '--noscreen' ]; then
    exit 1
else
    # check screen installed
    echo -e "\033[1;96m[INFO] Checking screen... \033[0m"
    screen -version

    # if the command above execute failed, install screen
    if [ $? -eq 1 ]; then
        echo -e "\033[1;96m[INFO] screen is installed. \033[0m"
    else
        echo -e "\033[1;96m[INFO] screen isn't installed. Start installing... \033[0m"
        sudo apt-get install screen -y 
        if [ $? -eq 0 ]; then
            echo -e "\033[1;93m[SUCCESS] screen installed successfully. \033[0m"
        else
            echo -e "\033[1;91m[ERROR] screen installed failed. \033[0m"
        fi
    fi   
fi
