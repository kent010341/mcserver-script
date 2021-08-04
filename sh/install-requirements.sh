#!/bin/sh

# check Java version
java -version

# if the command above execute failed, download the latest version of JDK
if [ $? -eq 0 ]; then
    echo "Java is installed."
else
    # install JDK 16 (for 1.17)
    echo "Java isn't installed. Start installing..."
    sudo apt-get install openjdk-16-jdk -y
fi

# check screen installed
screen -version

# if the command above execute failed, install screen
if [ ! $? -eq 0 ]; then
    echo -e "\033[31m[WARNING] screen isn't installed. Start installing... \033[0m"
    sudo apt-get install screen -y 
fi