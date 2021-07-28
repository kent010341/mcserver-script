#!/bin/sh

# stop server
if [ screen -list | grep -q "mc" ]; then
    sudo screen -r mc -X stuff '/stop\n'
else
    echo "screen session 'mc' doesn't exist."
    exit 1
fi

# generating the backup folder
if [ ! -d "./backup" ]; then
    echo "The 'backup' folder doesn't exist."
    mkdir backup
    ecdir "'backup' folder created."
fi

if [ -d "./world" ]; then
    cp -r ./world ./backup/world$(date +"%Y%m%d")
    echo "backup successed."
else
    echo "The 'world' folder doesn't exist."
    exit 1
fi

#======================================================
# restart server (same as screen-start-server.sh)

# default value
default_memory=2 # GB
default_filename=server.jar

#======================================================
# preparing variables & start server

# defaultly using 2GB memory for server
gb=${1:-$default_memory}
mb=$(expr $gb \* 1024)M

# defaultly using server.jar as file name
filename=${2:-$default_filename}

# start server with screen
screen -r mc -X stuff "java -Xmx$mb -Xms$mb -jar $filename nogui\n"
