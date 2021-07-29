#!/bin/sh

# default value
default_memory=2 # GB
default_filename=server.jar

#======================================================
# check screen installed
screen -version

# if the command above execute failed, install screen
if [ ! $? -eq 0 ]; then
    echo "screen isn't installed. Start installing..."
    sudo apt-get isntall screen -y 
fi

#======================================================
# preparing variables & start server

# defaultly using 2GB memory for server
gb=${1:-$default_memory}
mb=$(expr $gb \* 1024)M

# defaultly using server.jar as file name
filename=${2:-$default_filename}

# start server with screen
if [ ! screen -list | grep -q "mc" ]; then
    screen -S mc -X stuff "java -Xmx$mb -Xms$mb -jar $filename nogui\n"
else
    screen -r mc -X stuff "java -Xmx$mb -Xms$mb -jar $filename nogui\n"
fi
