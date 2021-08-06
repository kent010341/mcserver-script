#!/bin/sh

# check Java version
echo "\033[36m[INFO] Checking Java... \033[0m"
java -version

# if the command above execute failed, download the latest version of JDK
if [ $? -eq 0 ]; then
    echo "\033[36m[INFO] Java is installed. \033[0m"
else
    # install JDK 16 (for 1.17)
    echo "\033[36m[INFO] Java isn't installed. Start installing... \033[0m"
    sudo apt-get install openjdk-16-jdk -y
    if [ $? -eq 0 ]; then
        echo "\033[33m[SUCCESS] Java installed successfully. \033[0m"
    else
        echo "\033[31m[ERROR] Java installed failed. \033[0m"
    fi
fi

if [ $1 == '--noscreen' ]; then
    exit 1
else
    # check screen installed
    echo "\033[36m[INFO] Checking screen... \033[0m"
    screen -version

    # if the command above execute failed, install screen
    if [ $? -eq 0 ]; then
        echo "\033[36m[INFO] screen is installed. \033[0m"
    else
        echo "\033[36m[INFO] screen isn't installed. Start installing... \033[0m"
        sudo apt-get install screen -y 
        if [ $? -eq 0 ]; then
            echo "\033[33m[SUCCESS] screen installed successfully. \033[0m"
        else
            echo "\033[31m[ERROR] screen installed failed. \033[0m"
        fi
    fi   
fi
