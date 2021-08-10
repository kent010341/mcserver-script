#!/bin/bash

# default value
default_memory=2 # GB
default_filename=server.jar

#======================================================
# check screen installed
screen -version

# if the command above execute failed, install screen
if [ ! $? -eq 1 ]; then
    echo -e "\033[1;91m[WARNING] screen isn't installed. Start installing... \033[0m"
    sudo apt-get install screen -y 
    echo -e "\033[1;93m[SUCCESS] screen installed. \033[0m"
fi

#======================================================
# preparing variables & start server

# defaultly using 2GB memory for server
gb=${1:-$default_memory}
mb=$(expr $gb \* 1024)M

# defaultly using server.jar as file name
filename=${2:-$default_filename}

# test screen session "mc" exist
screen -r mc -X stuff "echo test\n"

# if the command above execute failed, create a detached screen
if [ ! $? -eq 0 ]; then
    screen -dmS mc
fi

# start server with screen
screen -r mc -X stuff "java -Xmx$mb -Xms$mb -jar $filename nogui\n"

echo -e "\033[1;93m[SUCCESS] Server has already started at a detached screen 'mc'. \033[0m"
echo -e "\033[1;93m[SUCCESS] Use 'screen -r mc' to get into the screen. (Use Ctrl + A + D to leave) \033[0m"
